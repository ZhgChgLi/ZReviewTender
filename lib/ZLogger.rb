$lib = File.expand_path('../', File.dirname(__FILE__))

require "logger"

class ZLogger
    
    attr_accessor :logger

    def initialize(baseExecutePath)
        @logger = Logger.new("#{baseExecutePath}/execute.log")
    end

    def logError(message)
        result = "#{caller[0]}: #{message}"
        logger.error(result)
    end

    def logWarn(message)
        result = "#{caller[0]}: #{message}"
        logger.warn(result)
    end

    def logInfo(message)
        result = "#{caller[0]}: #{message}"
        logger.info(result)
    end
end