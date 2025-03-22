
$lib = File.expand_path('../lib', File.dirname(__FILE__))


require "Processors/SlackProcessor"
require "Models/Processor"
require "time"

class ReviewFetcher

    attr_accessor :config, :platform, :processors, :logger

    def execute()

    end

    def registerProcessor(processor)
        processors.append(processor)
    end

    def processReviews(reviews, platform)
        processors.each do |processor|
            begin
                reviews = processor.processReviews(reviews, platform)
            rescue => e
                errorMessage = "# Processor Error"
                errorMessage += "#Error Message:  #{e.message}\n"
                errorMessage += "#Error Class: #{e.class}\n"
                errorMessage += "#Backtrace Start#\n#{e.backtrace.join("\n")}\n#Backtrace End#\n"
                logger.logError(errorMessage)
            end
        end
    end

    def sendWelcomMessage()
        slackProcessor = processors.find { |processor| processor.is_a?(SlackProcessor) }
        if !slackProcessor.nil?
            slackProcessor.sendWelcomMessage(platform)
        end
    end

    def setSentWelcomeMessage()
        basePath = "#{config.baseExecutePath}/latestCheckTimestamp/"
        Helper.createDirIfNotExist(basePath)
        File.open("#{basePath}/#{platform}Welcome", 'w') { |file| file.write("") }
    end

    def isSentWelcomeMessage()
        filePath = "#{config.baseExecutePath}/latestCheckTimestamp/#{platform}Welcome"
        return File.exist?(filePath)
    end

    def setPlatformLatestCheckTimestamp(timestamp)
        basePath = "#{config.baseExecutePath}/latestCheckTimestamp/"
        Helper.createDirIfNotExist(basePath)
        File.open("#{basePath}/#{platform}", 'w') { |file| file.write(timestamp) }
    end

    def getPlatformLatestCheckTimestamp()
        filePath = "#{config.baseExecutePath}/latestCheckTimestamp/#{platform}"
        if File.exist?(filePath)
            return File.read(filePath).to_i
        else
            return 0
        end
    end
end