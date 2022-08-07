$lib = File.expand_path('../', File.dirname(__FILE__))

require "logger"

class Helper
    def self.unwrapRequiredParameter(obj, key)
        if obj[key].nil?
            raise "Required Parameter Not Found: #{key}"
        else
            if obj[key] == ''
                raise "Required Parameter Is Empty: #{key}"
            else
                return obj[key]
            end
        end
    end

    def self.createDirIfNotExist(dirPath)
        dirs = dirPath.split("/")
        currentDir = ""
        begin
            dir = dirs.shift
            currentDir = "#{currentDir}/#{dir}"
            Dir.mkdir(currentDir) unless File.exists?(currentDir)
        end while dirs.length > 0
    end

    def self.logError(message)
        logger = Logger.new(STDOUT)
        logger.error("#{caller[0]}: #{message}")
    end

    def self.logWarn(message)
        logger = Logger.new(STDOUT)
        logger.warning("#{caller[0]}: #{message}")
    end

    def self.logInfo(message)
        logger = Logger.new(STDOUT)
        logger.info("#{caller[0]}: #{message}")
    end
end
