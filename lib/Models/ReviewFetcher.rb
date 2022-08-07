
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

    def setPlatformLatestCheckTimestamp()
        basePath = "#{config.baseExecutePath}/.cache"
        Helper.createDirIfNotExist(basePath)
        File.open("#{basePath}/#{platform}-latestCheckTimestamp", 'w') { |file| file.write(Time.now().to_i) }
    end

    def getPlatformLatestCheckTimestamp()
        filePath = "#{config.baseExecutePath}/.cache/#{platform}-latestCheckTimestamp"
        if File.exists?(filePath)
            return File.read(filePath).to_i
        else
            return 0
        end
    end
end