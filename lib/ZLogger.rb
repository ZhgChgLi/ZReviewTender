$lib = File.expand_path('../', File.dirname(__FILE__))

require "logger"

class ZLogger
    
    attr_accessor :logger

    def initialize(baseExecutePath)
        @logger = Logger.new("#{baseExecutePath}/execute.log")
    end

    def logError(message)
        result = "#{caller[0]}: #{message}"

        puts "Error: #{result}"
        logger.error(result)
    end

    def logWarn(message)
        result = "#{caller[0]}: #{message}"
        
        puts "Warning: #{result}"
        logger.warn(result)
    end

    def logInfo(message)
        result = "#{caller[0]}: #{message}"
        
        puts "Info: #{result}"
        logger.info(result)
    end
end