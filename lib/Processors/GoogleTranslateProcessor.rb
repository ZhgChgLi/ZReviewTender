$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Helper"
require "pathname"
require "jwt"
require "time"

class GoogleTranslateProcessor < Processor

    attr_accessor :keyContent, :keyID, :tokenURI, :clientEmail, :targetLang, :territoriesExclude, :token, :logger

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

        keyFileContent = JSON.parse(File.read(keyFilePath))

        @keyContent = Helper.unwrapRequiredParameter(keyFileContent,"private_key")
        @keyID = Helper.unwrapRequiredParameter(keyFileContent,"private_key_id")
        @clientEmail = Helper.unwrapRequiredParameter(keyFileContent,"client_email")
        @tokenURI = Helper.unwrapRequiredParameter(keyFileContent,"token_uri")

        @targetLang = Helper.unwrapRequiredParameter(config, "googleTranslateTargetLang")
        @territoriesExclude = []
        if !config['googleTranslateTerritoriesExclude'].nil? && config['googleTranslateTerritoriesExclude'].length > 0
            @territoriesExclude = config['googleTranslateTerritoriesExclude']
        end

        @token = generateJWT()

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
                translateTitle = translate(reviews[index].title)
                if !translateTitle.nil? && translateTitle != reviews[index].title
                    reviews[index].title = "#{translateTitle} (#{reviews[index].title})"
                end
            end

            if !reviews[index].body.nil?
                translateBody = translate(reviews[index].body)
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

    private
    def generateJWT()
        payload = {
            iss: clientEmail,
            sub: clientEmail,
            scope: ["https://www.googleapis.com/auth/cloud-translation","https://www.googleapis.com/auth/cloud-platform"].join(' '),
            aud: tokenURI,
            iat: Time.now.to_i,
            exp: Time.now.to_i + 60*20
        }

        rsa_private = OpenSSL::PKey::RSA.new(keyContent)
        token = JWT.encode payload, rsa_private, 'RS256', header_fields = {kid:keyID, typ:"JWT"}

        uri = URI(tokenURI)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        request = Net::HTTP::Post.new(uri)
        request.body = "grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer&assertion=#{token}"

        response = https.request(request).read_body
        result = JSON.parse(response)
        
        return result["access_token"]
    end

    private
    def translate(text, retryCount = 0)
        uri = URI("https://translation.googleapis.com/language/translate/v2")
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        
        request = Net::HTTP::Post.new(uri)
        request.body = "q=#{text}&target=#{targetLang}"
        request['Authorization'] = "Bearer #{token}";
        
        response = https.request(request).read_body
        
        result = JSON.parse(response)
        translate = result&.dig("data", "translations", 0, "translatedText")
        if translate.nil?
            if retryCount >= 10
                raise "Could not connect to translation.googleapis.com, error message: #{response}"
            else
                @token = generateJWT()
                message = "JWT Expired, refresh a new one. (#{retryCount + 1})"
                logger.logWarn(message)
                puts "[GoogleTranslateProcessor] #{message}"
                return request(text, retryCount + 1)
            end
        else
            return translate
        end

    end
end