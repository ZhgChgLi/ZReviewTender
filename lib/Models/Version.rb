$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "net/http"

class Version
    def getLocalVersion()
        versionFilePath = "#{File.expand_path("../..", __dir__)}/.version"
        
        result = nil
        if File.file?(versionFilePath)
            result = File.read(versionFilePath).strip
        else
            result = Gem.loaded_specs["ZReviewTender"].version.version
        end

        if !result.nil?
            Gem::Version.new(result)
        else
            nil
        end
    end

    def getRemoteVersion()
        apiPath = 'https://rubygems.org/api/v1/gems/ZReviewTender.json'
        
        uri = URI(apiPath)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        request = Net::HTTP::Get.new(uri)
        response = https.request(request).read_body
        result = JSON.parse(response)
        
        if !result['version'].nil?
            Gem::Version.new(result['version'])
        else
            nil
        end
    end
end