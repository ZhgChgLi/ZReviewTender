$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Helper"
require "ZLogger"
require "Models/ReviewFetcher"
require "jwt"
require "time"
require "net/http"

class AppleFetcher < ReviewFetcher

    attr_accessor :token

    def initialize(config)
        @processors = []
        @config = config
        @logger = ZLogger.new(config.baseExecutePath)
        @platform = 'Apple'
        @token = generateJWT()
    end

    def execute()

        latestCheckTimestamp = getPlatformLatestCheckTimestamp()


        # init first time, send welcome message
        if latestCheckTimestamp == 0 
            sendWelcomMessage()
            setPlatformLatestCheckTimestamp(Time.now().to_i)
            return;
        end

        reviews = fetchReviews(latestCheckTimestamp)

        if reviews.length > 0
            reviews.sort! { |a, b|  a.createdDateTimestamp <=> b.createdDateTimestamp }
            setPlatformLatestCheckTimestamp(reviews.last.createdDateTimestamp)

            reviews = fullfillAppInfo(reviews)
            processReviews(reviews, platform)
        end
    end

    private
    def fetchReviews(latestCheckTimestamp)
        customerReviewsLink = "https://api.appstoreconnect.apple.com/v1/apps/#{config.appID}/customerReviews?sort=-createdDate"
        reviews = []

        loop do
            customerReviews = request(customerReviewsLink)
            customerReviewsLink = customerReviews&.dig("links", "next")

            customerReviews&.dig("data").each do |customerReview|

                customerReviewID = customerReview&.dig("id")
                customerReviewTitle = customerReview&.dig("attributes","title")
                customerReviewBody= customerReview&.dig("attributes","body")
                customerReviewRating = customerReview&.dig("attributes","rating").to_i
                customerReviewReviewerNickname = customerReview&.dig("attributes","reviewerNickname")
                customerReviewCreatedDate = customerReview&.dig("attributes","createdDate")
                customerReviewTerritory = customerReview&.dig("attributes","territory")
                
                customerReviewCreatedDateTimestamp = 0
                if !customerReviewCreatedDate.nil?
                    customerReviewCreatedDateTimestamp = Time.parse(customerReviewCreatedDate).to_i
                end

                if latestCheckTimestamp >= customerReviewCreatedDateTimestamp
                    customerReviewsLink = nil
                    break
                else
                    url = "https://appstoreconnect.apple.com/apps/#{config.appID}/appstore/activity/ios/ratingsResponses"
                    reviews.append(Review.new(nil, customerReviewID, customerReviewReviewerNickname, customerReviewRating, customerReviewTitle, customerReviewBody, customerReviewCreatedDateTimestamp, url, nil, customerReviewTerritory))
                end
            end

            break if customerReviewsLink.nil?
        end

        return reviews
    end

    private
    def fullfillAppInfo(reviews)
        customerReviewWhichAppVersionIsNil = reviews.select{ |review| review.appVersion.nil? }.map.with_index { |review, index| {"id":review.id, "index": index} }

        appStoreVersionsLink = "https://api.appstoreconnect.apple.com/v1/apps/#{config.appID}/appStoreVersions"

        loop do
            appStoreVersions = request(appStoreVersionsLink)
            appStoreVersionsLink = appStoreVersions&.dig("links", "next")

            appStoreVersions&.dig("data").each do |appStoreVersion|
                applePlatform = appStoreVersion&.dig("attributes","platform")
                versionString = appStoreVersion&.dig("attributes","versionString")
                customerReviewsLink = appStoreVersion&.dig("relationships","customerReviews","links","related")

                if !customerReviewsLink.nil?
                    customerReviewsLink = "#{customerReviewsLink}?sort=-createdDate&limit=200"
                        
                    loop do
                        customerReviews = request(customerReviewsLink)
                        customerReviewsLink = customerReviews&.dig("links", "next")

                        customerReviews&.dig("data").each do |customerReview|
                            customerReviewID = customerReview&.dig("id")
                            if customerReviewID.nil?
                                next
                            end
                            findIndex = customerReviewWhichAppVersionIsNil.find_index { |value| value[:id] == customerReviewID }
                            if !findIndex.nil?
                                findResult = customerReviewWhichAppVersionIsNil[findIndex]
                                reviews[findResult[:index]].appVersion = versionString
                                reviews[findResult[:index]].platform = applePlatform

                                customerReviewWhichAppVersionIsNil.delete_at(findIndex)

                                if customerReviewWhichAppVersionIsNil.length < 1
                                    customerReviewsLink = nil
                                    break
                                end
                            end
                        end

                        break if customerReviewsLink.nil?
                    end
                end

                if customerReviewWhichAppVersionIsNil.length < 1
                    appStoreVersionsLink = nil
                    break
                end
            end

            break if appStoreVersionsLink.nil?
        end

        return reviews
    end

    private
    def generateJWT()
        payload = {
            iss: config.issueID,
            iat: Time.now.to_i,
            exp: Time.now.to_i + 60*20,
            aud: 'appstoreconnect-v1'
        }
        token = JWT.encode payload, config.keyContent, 'ES256', header_fields={kid:config.keyID, typ:"JWT"}
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
        if !result["errors"].nil?
            if retryCount >= 10
                raise "Could not connect to api.appstoreconnect.apple.com, error message: #{response}"
            else
                @token = generateJWT()
                logger.logWarn("JWT Expired, refresh a new one. (#{retryCount + 1})")
                return request(url, retryCount + 1)
            end
        else
            return result
        end

    end
end