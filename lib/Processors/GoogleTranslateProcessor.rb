$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Helper"

require "pathname"
require "google/cloud/translate/v2"

class GoogleTranslateProcessor < Processor

    attr_accessor :client, :targetLang, :whiteListTerritories

    def initialize(config, configFilePath, baseExecutePath)
        @config = config
        @configFilePath = configFilePath
        @baseExecutePath = baseExecutePath

        keyFilePath = Helper.unwrapRequiredParameter(config, "googleTranslateAPIKeyFilePath")

        if Pathname.new(keyFilePath).absolute?
            configDir = File.dirname(configFilePath)
            keyFilePath = "#{configDir}#{keyFilePath}"
        end

        ENV["TRANSLATE_CREDENTIALS"] = keyFilePath
        @client = Google::Cloud::Translate::V2.new
        @targetLang = Helper.unwrapRequiredParameter(config, "googleTranslateTargetLang")
        @whiteListTerritories = []
        if !config['googleTranslateWhiteListTerritories'].nil? && config['googleTranslateWhiteListTerritories'].length > 0
            @whiteListTerritories = config['googleTranslateWhiteListTerritories']
        end
    end

    def processReviews(reviews, platform)
        reviews.each_index do |index|
            if whiteListTerritories.include? reviews[index].territory
                next
            end

            if !reviews[index].title.nil?
                reviews[index].title = "#{client.translate reviews[index].title, to: targetLang} (#{reviews[index].title})"
            end
            body = "#{client.translate reviews[index].body, to: targetLang}"
            body += "\r\n===== Translate by Google =====\r\n"
            body += reviews[index].body
            reviews[index].body = body
        end

        return reviews
    end

end