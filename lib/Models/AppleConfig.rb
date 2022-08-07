$lib = File.expand_path('../', File.dirname(__FILE__))

require "pathname"
require "Helper"
require "openssl"

class AppleConfig
    attr_accessor :keyContent, :keyID, :issueID, :appID, :baseExecutePath
    def initialize(configYMLObj, configFilePath, baseExecutePath)
        keyFilePath = Helper.unwrapRequiredParameter(configYMLObj,"appStoreConnectP8PrivateKeyFilePath")

        if Pathname.new(keyFilePath).absolute?
            configDir = File.dirname(configFilePath)
            keyFilePath = "#{configDir}#{keyFilePath}"
        end

        keyFile = File.read(keyFilePath)
        @keyContent = OpenSSL::PKey::EC.new(keyFile)

        @baseExecutePath = baseExecutePath
        @keyID = Helper.unwrapRequiredParameter(configYMLObj,"appStoreConnectP8PrivateKeyID")
        @issueID = Helper.unwrapRequiredParameter(configYMLObj,"appStoreConnectIssueID")
        @appID = Helper.unwrapRequiredParameter(configYMLObj,"appID")
    end
end