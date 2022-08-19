$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Helper"
require "Models/ReviewFetcher"
require "jwt"
require "time"

class AndroidFetcher < ReviewFetcher

    attr_accessor :token

    def initialize(config)
        @processors = []
        @config = config
        @platform = 'Android'
        @logger = ZLogger.new(config.baseExecutePath)
        @token = generateJWT()

        puts "[AndroidFetcher] Init Success."
    end

    def execute()

        latestCheckTimestamp = getPlatformLatestCheckTimestamp()

        puts "[AndroidFetcher] Start execute(), latestCheckTimestamp: #{latestCheckTimestamp}"

        reviews = []

        reviewsInfoLink = "https://androidpublisher.googleapis.com/androidpublisher/v3/applications/#{config.packageName}/reviews"

        # Note: You can retrieve only the reviews that users have created or modified within the last week. 
        # https://developers.google.com/android-publisher/reply-to-reviews#retrieving_a_set_of_reviews

        puts "[AndroidFetcher] Fetch reviews in #{config.packageName}"

        loop do
            reviewsInfo = request(reviewsInfoLink)
            reviewsInfoLink = reviewsInfo&.dig("tokenPagination", "nextPageToken")

            customerReviews = reviewsInfo["reviews"]
            puts "[AndroidFetcher] Fetch reviews in #{config.packageName}, count: #{customerReviews.length}"
            customerReviews.each do |customerReview|

                customerReviewID = customerReview&.dig("reviewId")
                customerReviewTitle = nil
                customerReviewReviewerNickname = customerReview&.dig("authorName")
                customerReviewVersionString = "unknown"
                customerReviewPlatform = platform
                customerReviewCreatedDateTimestamp = 0
                
                comment = customerReview&.dig("comments", 0, "userComment")
                if !comment.nil?
                    customerReviewBody = comment&.dig("text")
                    customerReviewTerritory = comment&.dig("reviewerLanguage")

                    if !customerReviewBody.nil?
                        customerReviewBody = customerReviewBody.strip
                    end

                    customerReviewRating = comment&.dig("starRating")
                    if !customerReviewRating.nil?
                        customerReviewRating = customerReviewRating.to_i
                    end

                    customerReviewCreatedDateTimestamp = comment&.dig("lastModified", "seconds")
                    if !customerReviewCreatedDateTimestamp.nil?
                        customerReviewCreatedDateTimestamp = customerReviewCreatedDateTimestamp.to_i
                    end

                    androidOSVersion = comment&.dig("androidOsVersion")
                    if !androidOSVersion.nil?
                        customerReviewPlatform = "#{platform} #{androidOSVersion}"
                    end

                    versionString = comment&.dig("appVersionName")
                    if !versionString.nil?
                        customerReviewVersionString = "#{versionString}"

                        versionCode = comment&.dig("appVersionCode")
                        if !versionCode.nil?
                            customerReviewVersionString = "#{customerReviewVersionString}(#{versionCode})"
                        end
                    end

                    deviceInfo = []
                    manufacturer = comment&.dig("deviceMetadata", "manufacturer")
                    if !manufacturer.nil?
                        deviceInfo.append(manufacturer)
                    end

                    productName = comment&.dig("deviceMetadata", "productName")
                    if !productName.nil?
                        deviceInfo.append(productName)
                    end

                    if deviceInfo.length > 0
                        customerReviewTitle = "#{deviceInfo.join("/")}"
                    end
                end

                if latestCheckTimestamp >= customerReviewCreatedDateTimestamp
                    reviewsInfoLink = nil
                    break
                else
                    url = "https://play.google.com/store/apps/details?id=#{config.packageName}&reviewId=#{customerReviewID}"
                    if !config.accountID.nil? && !config.appID.nil?
                        url = "https://play.google.com/console/developers/#{config.accountID}/app/#{config.appID}/user-feedback/review-details?reviewId=#{customerReviewID}"
                    end
                    reviews.append(Review.new(customerReviewPlatform, customerReviewID, customerReviewReviewerNickname, customerReviewRating, customerReviewTitle, customerReviewBody, customerReviewCreatedDateTimestamp, url, customerReviewVersionString, customerReviewTerritory))
                    
                    # init first time, need first review to set as latestCheckTimestamp
                    if latestCheckTimestamp == 0
                        reviewsInfoLink = nil
                        break
                    end
                end
            end
            
            break if reviewsInfoLink.nil?
        end

        puts "[AndroidFetcher] Fetch reviews in #{config.packageName}, total reviews count: #{reviews.length}"

        if reviews.length > 0
            reviews = reviews.sort! { |a, b|  a.createdDateTimestamp <=> b.createdDateTimestamp }

            puts "[AndroidFetcher] latest review: #{reviews.last.body}, #{reviews.last.createdDateTimestamp}"
            setPlatformLatestCheckTimestamp(reviews.last.createdDateTimestamp)

            # init first time, send welcome message
            if latestCheckTimestamp == 0 
                sendWelcomMessage()
                return
            end

            processReviews(reviews, platform)
        end
    end

    private
    def generateJWT()
        payload = {
            iss: config.clientEmail,
            sub: config.clientEmail,
            scope: "https://www.googleapis.com/auth/androidpublisher",
            aud: config.tokenURI,
            iat: Time.now.to_i,
            exp: Time.now.to_i + 60*20
        }

        rsa_private = OpenSSL::PKey::RSA.new(config.keyContent)
        token = JWT.encode payload, rsa_private, 'RS256', header_fields = {kid:config.keyID, typ:"JWT"}

        uri = URI(config.tokenURI)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        request = Net::HTTP::Post.new(uri)
        request.body = "grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer&assertion=#{token}"

        response = https.request(request).read_body
        result = JSON.parse(response)
        
        return result["access_token"]
    end

    private
    def request(url, retryCount = 0)
        uri = URI(url)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        
        request = Net::HTTP::Get.new(uri)
        request['Authorization'] = "Bearer #{token}";
        
        response = https.request(request).read_body
        
        result = JSON.parse(response)
        if result["reviews"].nil?
            if retryCount >= 10
                raise "Could not connect to androidpublisher.googleapis.com, error message: #{response}"
            else
                @token = generateJWT()
                message = "JWT Expired, refresh a new one. (#{retryCount + 1})"
                logger.logWarn(message)
                puts "[AndroidFetcher] #{message}"
                return request(url, retryCount + 1)
            end
        else
            return result
        end

    end
end