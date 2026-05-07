$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Helper"
require "pathname"
require "GoogleAPI"

class GoogleTranslateProcessor < Processor

    register "google_translate"

    TRANSLATE_API_URL = "https://translation.googleapis.com/language/translate/v2".freeze

    attr_accessor :targetLang, :territoriesExclude, :googleAPI

    def validate_config!
        keyFilePath = Helper.unwrapRequiredParameter(config, "googleTranslateAPIKeyFilePath")
        if Pathname.new(keyFilePath).absolute?
            configDir = File.dirname(configFilePath)
            keyFilePath = "#{configDir}#{keyFilePath}"
        end

        @googleAPI = GoogleAPI.new(keyFilePath, baseExecutePath, [
            "https://www.googleapis.com/auth/cloud-translation",
            "https://www.googleapis.com/auth/cloud-platform"
        ])

        @targetLang         = Helper.unwrapRequiredParameter(config, "googleTranslateTargetLang")
        @territoriesExclude = Array(config["googleTranslateTerritoriesExclude"])

        puts "[GoogleTranslateProcessor] Init Success."
    end

    def process_reviews(reviews, platform)
        return reviews if reviews.empty?

        reviews.each do |review|
            next if territoriesExclude.include?(review.territory)

            puts "[GoogleTranslateProcessor] translate #{review.body} from #{review.territory} to #{targetLang}"

            unless review.title.nil?
                translated = translate(review.title)
                if !translated.nil? && translated != review.title
                    review.title = "#{translated} (#{review.title})"
                end
            end

            unless review.body.nil?
                translated = translate(review.body)
                if !translated.nil? && translated != review.body
                    body  = translated.dup
                    body += "\r\n===== Translate by Google =====\r\n"
                    body += review.body
                    review.body = body
                end
            end
        end

        reviews
    end

    private

    def translate(text)
        result = googleAPI.request(TRANSLATE_API_URL, "POST", {:q => text, :target => targetLang})
        result&.dig("data", "translations", 0, "translatedText")
    end
end
