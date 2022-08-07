$lib = File.expand_path('../', File.dirname(__FILE__))

class Processor

    attr_accessor :config, :configFilePath, :baseExecutePath

    def initialize(config, configFilePath, baseExecutePath)
        @config = config
        @configFilePath = configFilePath
        @baseExecutePath = baseExecutePath
    end

    def processReviews(reviews, platform)

    end
end