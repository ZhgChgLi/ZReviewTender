$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Helper"
require "pathname"
require "GoogleAPI"

class GoogleTranslateProcessor < Processor

    attr_accessor :targetLang, :territoriesExclude, :token, :logger, :googleAPI

    def initialize(config, configFilePath, baseExecutePath)
        @config = config
        @configFilePath = configFilePath
        @baseExecutePath = baseExecutePath
        @logger = ZLogger.new(baseExecutePath)

        keyFilePath = Helper.unwrapRequiredParameter(config, "googleTranslateAPIKeyFilePath")

        if Pathname.new(keyFilePath).absolute?
            configDir = File.dirname(configFilePath)
            keyFilePath = "#{configDir}#{keyFilePath}"
        end

        @googleAPI = GoogleAPI.new(keyFilePath, baseExecutePath, ["https://www.googleapis.com/auth/cloud-translation","https://www.googleapis.com/auth/cloud-platform"])

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
                #next
            end

            puts "[GoogleTranslateProcessor] translate #{reviews[index].body} from #{reviews[index].territory} to #{targetLang}"

            if !reviews[index].title.nil?
                translateTitle = googleAPI.request("https://translation.googleapis.com/language/translate/v2", "POST", {:q => reviews[index].title, :target => targetLang})
                translateTitle = translateTitle&.dig("data", "translations", 0, "translatedText")
                if !translateTitle.nil? && translateTitle != reviews[index].title
                    reviews[index].title = "#{translateTitle} (#{reviews[index].title})"
                end
            end

            if !reviews[index].body.nil?
                translateBody = googleAPI.request("https://translation.googleapis.com/language/translate/v2", "POST", {:q => reviews[index].body, :target => targetLang})
                translateBody = translateBody&.dig("data", "translations", 0, "translatedText")
                if !translateBody.nil? && translateBody != reviews[index].body
                    body = "#{translateBody}"
                    body += "\r\n===== Translate by Google =====\r\n"
                    body += reviews[index].body
                    reviews[index].body = body
                end
            end
        end

        return reviews
    end
end