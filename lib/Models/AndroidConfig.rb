$lib = File.expand_path('../', File.dirname(__FILE__))

require "pathname"
require "Helper"
require "time"

class AndroidConfig
    attr_accessor :keyFilePath, :packageName, :accountID, :appID, :baseExecutePath
    def initialize(configYMLObj, configFilePath, baseExecutePath)
        @keyFilePath = Helper.unwrapRequiredParameter(configYMLObj,"keyFilePath")

        if Pathname.new(keyFilePath).absolute?
            configDir = File.dirname(configFilePath)
            @keyFilePath = "#{configDir}#{keyFilePath}"
        end

        @accountID = configYMLObj["playConsoleDeveloperAccountID"]
        @appID = configYMLObj["playConsoleAppID"]
        @baseExecutePath = baseExecutePath
        @packageName = Helper.unwrapRequiredParameter(configYMLObj,"packageName")
    end
end