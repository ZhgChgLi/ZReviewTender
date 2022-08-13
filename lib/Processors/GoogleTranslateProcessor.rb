$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Helper"

require "pathname"
require "google/cloud/translate/v2"

class GoogleTranslateProcessor < Processor

    attr_accessor :client, :targetLang, :territoriesExclude

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
        @territoriesExclude = []
        if !config['googleTranslateTerritoriesExclude'].nil? && config['googleTranslateTerritoriesExclude'].length > 0
            @territoriesExclude = config['googleTranslateTerritoriesExclude']
        end

        puts "[GoogleTranslateProcessor] Init Success."
    end

    def processReviews(reviews, platform)
        if reviews.length < 1
            return reviews
        end
        
        reviews.each_index do |index|
            if territoriesExclude.include? reviews[index].territory
                next
            end

            puts "[GoogleTranslateProcessor] translate #{reviews[index].body} from #{reviews[index].territory} to #{targetLang}"

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