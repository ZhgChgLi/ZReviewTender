$lib = File.expand_path('../', File.dirname(__FILE__))

require "pathname"
require "Helper"
require "time"

class AndroidConfig
    attr_accessor :keyContent, :keyID, :tokenURI, :clientEmail, :packageName, :accountID, :appID, :baseExecutePath
    def initialize(configYMLObj, configFilePath, baseExecutePath)
        keyFilePath = Helper.unwrapRequiredParameter(configYMLObj,"keyFilePath")

        if Pathname.new(keyFilePath).absolute?
            configDir = File.dirname(configFilePath)
            keyFilePath = "#{configDir}#{keyFilePath}"
        end

        keyFileContent = JSON.parse(File.read(keyFilePath))

        @accountID = configYMLObj["playConsoleDeveloperAccountID"]
        @appID = configYMLObj["playConsoleAppID"]
        @keyContent = Helper.unwrapRequiredParameter(keyFileContent,"private_key")
        @keyID = Helper.unwrapRequiredParameter(keyFileContent,"private_key_id")
        @clientEmail = Helper.unwrapRequiredParameter(keyFileContent,"client_email")
        @tokenURI = Helper.unwrapRequiredParameter(keyFileContent,"token_uri")
        @baseExecutePath = baseExecutePath
        @packageName = Helper.unwrapRequiredParameter(configYMLObj,"packageName")
    end
end