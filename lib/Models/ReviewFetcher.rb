
$lib = File.expand_path('../lib', File.dirname(__FILE__))


require "Processors/SlackProcessor"
require "Models/Processor"
require "time"

class ReviewFetcher

    attr_accessor :config, :platform, :processors

    def execute()

    end

    def registerProcessor(processor)
        processors.append(processor)
    end

    def processReviews(reviews, platform)
        processors.each do |processor|
            reviews = processor.processReviews(reviews, platform)
        end
    end

    def sendWelcomMessage()
        slackProcessor = processors.find { |processor| processor.is_a?(SlackProcessor) }
        if !slackProcessor.nil?
            slackProcessor.sendWelcomMessage(platform)
        end
    end

    def setPlatformLatestCheckTimestamp(timestamp)
        basePath = "#{config.baseExecutePath}/latestCheckTimestamp/"
        Helper.createDirIfNotExist(basePath)
        File.open("#{basePath}/#{platform}", 'w') { |file| file.write(timestamp) }
    end

    def getPlatformLatestCheckTimestamp()
        filePath = "#{config.baseExecutePath}/latestCheckTimestamp/#{platform}"
        if File.exists?(filePath)
            return File.read(filePath).to_i
        else
            return 0
        end
    end
end