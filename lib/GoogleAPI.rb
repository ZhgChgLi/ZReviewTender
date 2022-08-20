$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "jwt"
require "time"

class GoogleAPI < Processor

    attr_accessor :keyContent, :keyID, :tokenURI, :clientEmail, :logger, :scopes, :token

    def initialize(keyFilePath, baseExecutePath, scopes = [])

        @logger = ZLogger.new(baseExecutePath)

        keyFileContent = JSON.parse(File.read(keyFilePath))

        @keyContent = Helper.unwrapRequiredParameter(keyFileContent,"private_key")
        @keyID = Helper.unwrapRequiredParameter(keyFileContent,"private_key_id")
        @clientEmail = Helper.unwrapRequiredParameter(keyFileContent,"client_email")
        @tokenURI = Helper.unwrapRequiredParameter(keyFileContent,"token_uri")

        @scopes = scopes

        @token = generateJWT()

        puts "[GoogleAPI] Init Success."
    end

    def request(url, method = "GET", data = nil, retryCount = 0)
        uri = URI(url)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        
        request = Net::HTTP::Get.new(uri)
        if method.upcase == "POST"
            request = Net::HTTP::Post.new(uri)
            if !data.nil?
                request['Content-Type'] = 'application/json'
                request.body = JSON.dump(data)
            end
        end
        
        request['Authorization'] = "Bearer #{token}";
        
        response = https.request(request).read_body
        result = JSON.parse(response)

        if !result["error"].nil?
            if retryCount >= 10
                raise "Could not connect to #{tokenURI}, key id: #{keyID}, error message: #{response}"
            else
                @token = generateJWT()
                message = "JWT Invalid, retry. (#{retryCount + 1})"
                logger.logWarn(message)
                puts "[GoogleAPI] #{message}"
                return request(url, method, data, retryCount + 1)
            end
        else
            return result
        end

    end

    private
    def generateJWT(retryCount = 0)
        payload = {
            iss: clientEmail,
            sub: clientEmail,
            scope: scopes.join(' '),
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

        if result["access_token"].nil?
            if retryCount >= 10
                raise "Could not generate google api JWT, key id: #{keyID}, error message: #{response}"
            else
                message = "Could not generate google api JWT, retry. (#{retryCount + 1})"
                logger.logWarn(message)
                puts "[GoogleAPI] #{message}"
                return generateJWT(retryCount + 1)
            end
        else
            return result["access_token"]
        end
    end
end