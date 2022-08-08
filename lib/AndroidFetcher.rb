$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Helper"
require "Models/ReviewFetcher"
require "time"
require "google/apis/androidpublisher_v3"

class AndroidFetcher < ReviewFetcher

    attr_accessor :token, :client

    def initialize(config)
        @processors = []
        @config = config
        @platform = 'Android'

        @client = Google::Apis::AndroidpublisherV3::AndroidPublisherService.new
        @client.authorization = Google::Auth::ServiceAccountCredentials.make_creds(json_key_io: config.keyContent, scope: 'https://www.googleapis.com/auth/androidpublisher')
    end

    def execute()

        latestCheckTimestamp = getPlatformLatestCheckTimestamp()

        reviews = []
        
        # Google API Bug, couldn't specify limit/offse/pagination, google only return a few recent reviews.
        customerReviews = client.list_reviews(config.packageName).reviews
        customerReviews.each do |customerReview|

            customerReviewID = customerReview.review_id
            customerReviewTitle = nil
            customerReviewBody = customerReview.comments[0].user_comment.text.strip
            customerReviewRating = customerReview.comments[0].user_comment.star_rating.to_i
            customerReviewReviewerNickname = customerReview.author_name
            customerReviewCreatedDateTimestamp = customerReview.comments[0].user_comment.last_modified.seconds.to_i
            customerReviewTerritory = customerReview.comments[0].user_comment.reviewer_language
            customerReviewVersionString = "unknown"
            if !customerReview.comments[0].user_comment.app_version_name.nil?
                customerReviewVersionString = "#{customerReview.comments[0].user_comment.app_version_name}"
                if !customerReview.comments[0].user_comment.app_version_code.nil?
                    customerReviewVersionString = "#{customerReviewVersionString}(#{customerReview.comments[0].user_comment.app_version_code})"
                end
            end
            customerReviewPlatform = "Android #{customerReview.comments[0].user_comment.android_os_version}"
            
            url = "https://play.google.com/store/apps/details?id=#{config.packageName}&reviewId=#{customerReviewID}"
            if !config.accountID.nil? && !config.appID.nil?
                url = "https://play.google.com/console/developers/#{config.accountID}/app/#{config.appID}/user-feedback/review-details?reviewId=#{customerReviewID}"
            end
            reviews.append(Review.new(customerReviewPlatform, customerReviewID, customerReviewReviewerNickname, customerReviewRating, customerReviewTitle, customerReviewBody, customerReviewCreatedDateTimestamp, url, customerReviewVersionString, customerReviewTerritory))
        end

        reviews = reviews.reject{ |review| latestCheckTimestamp >= review.createdDateTimestamp }.sort! { |a, b|  a.createdDateTimestamp <=> b.createdDateTimestamp }
      
        if reviews.length > 0

            setPlatformLatestCheckTimestamp(reviews.last.createdDateTimestamp)

            # init first time, send welcome message
            if latestCheckTimestamp == 0 
                sendWelcomMessage()
                return
            end

            processReviews(reviews, platform)
        end
    end
end