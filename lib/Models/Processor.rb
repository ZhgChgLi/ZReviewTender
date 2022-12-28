$lib = File.expand_path('../', File.dirname(__FILE__))

class Processor

    attr_accessor :config, :configFilePath, :baseExecutePath

    def initialize(config, configFilePath, baseExecutePath)
        @config = config
        @configFilePath = configFilePath
        @baseExecutePath = baseExecutePath
    end

    def processReviews(reviews, platform)

    end

    def renderReview(templateText, review, timeZoneOffset)
        templateText = templateText.gsub("%TITLE%", review.title || "")
        templateText = templateText.gsub("%BODY%", review.body || "")
        templateText = templateText.gsub("%RATING%", review.rating.nil? ? "" :review.rating.to_s)
        templateText = templateText.gsub("%PLATFORM%", review.platform || "")
        templateText = templateText.gsub("%ID%", review.id || "")
        templateText = templateText.gsub("%USERNAME%", review.userName || "")
        templateText = templateText.gsub("%URL%", review.url || "")
        templateText = templateText.gsub("%TERRITORY%", review.territory || "")
        templateText = templateText.gsub("%APPVERSION%", review.appVersion || "")
        templateText = templateText.gsub("%CREATEDDATE%", review.createdDateTimestamp.nil? ? "" : Time.at(review.createdDateTimestamp).getlocal(timeZoneOffset).to_s)

        return templateText
    end
end