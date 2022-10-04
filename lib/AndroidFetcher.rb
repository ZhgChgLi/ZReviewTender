$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Helper"
require "GoogleAPI"
require "Models/Review"
require "Models/ReviewFetcher"

class AndroidFetcher < ReviewFetcher

    attr_accessor :token, :googleAPI

    def initialize(config)
        @processors = []
        @config = config
        @platform = 'Android'
        @logger = ZLogger.new(config.baseExecutePath)
        @googleAPI = GoogleAPI.new(config.keyFilePath, config.baseExecutePath, ["https://www.googleapis.com/auth/androidpublisher"])

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
            reviewsInfo = googleAPI.request(reviewsInfoLink)
            reviewsInfoLink = reviewsInfo&.dig("tokenPagination", "nextPageToken")

            customerReviews = reviewsInfo["reviews"]

            if customerReviews.nil?
                break
            end

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
                        customerReviewReviewerNickname = "#{customerReviewReviewerNickname} - #{deviceInfo.join("/")}"
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
        end


        # init first time, send welcome message
        if latestCheckTimestamp == 0 
            sendWelcomMessage()
        elsif reviews.length > 0
            processReviews(reviews, platform)
        end
    end
end