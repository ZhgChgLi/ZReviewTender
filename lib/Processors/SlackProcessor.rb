$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Helper"
require "net/http"
require "json"
require "time"

class SlackProcessor < Processor

    attr_accessor :botToken, :inCommingWebHookURL, :targetChannel, :timeZoneOffset

    def initialize(config, configFilePath, baseExecutePath)
        @config = config
        @configFilePath = configFilePath
        @baseExecutePath = baseExecutePath

        @botToken = config["slackBotToken"]
        @inCommingWebHookURL = config["slackInCommingWebHookURL"]
        @targetChannel = config["slackBotTargetChannel"]
        @timeZoneOffset = Helper.unwrapRequiredParameter(config, "slackTimeZoneOffset")

        if (botToken.nil? && inCommingWebHookURL.nil?) || (botToken == "" && inCommingWebHookURL == "")
            raise "must specify slackBotToken or slackInCommingWebHookURL in SlackProcessor."
        elsif !botToken.nil? && botToken != "" && (targetChannel.nil? || targetChannel == "")
            raise "must specify slackBotTargetChannel in SlackProcessor."
        end
    end

    def processReviews(reviews, platform)
        reviews.each_slice(50) do |reviewGroup|
            payload = Payload.new()
            payload.attachments = []

            reviewGroup.each do |review|
                attachment = Payload::Attachment.new()

                stars = "★" * review.rating + "☆" * (5 - review.rating)
                color = review.rating >= 4 ? "good" : (review.rating > 2 ? "warning" : "danger")
                date = Time.at(review.createdDateTimestamp).getlocal(timeZoneOffset)
                
                title = "#{stars}"
                if !review.title.nil?
                    title = "#{review.title} - #{stars}"
                end
                    
                attachment.color = color
                attachment.author_name = review.userName
                attachment.fallback = title
                attachment.title = title
                attachment.text = review.body
                attachment.footer = "#{platform} - #{review.platform} - #{review.appVersion} - #{review.territory} - <#{review.url}|#{date}>"
                
                payload.attachments.append(attachment)
            end

            result = request(payload)
            if result["ok"] != true
                Helper.logError(result)
            end
        end

        return reviews
    end

    def sendWelcomMessage(platform)
        payload = Payload.new()
        payload.attachments = []

        attachment = Payload::Attachment.new()
            
        title = "ZReviewTender Standing By :astronaut:"
        body = "#{platform} Init Success!, will resend App Review to this channel automatically."
        
        attachment.color = "good"
        attachment.author_name = "<https://zhgchg.li|ZhgChgLi>"
        attachment.fallback = title
        attachment.title = title
        attachment.text = body
        attachment.footer = "Powered by "
        
        payload.attachments.append(attachment)

        request(payload)
    end

    private
    def request(payload)
        if !botToken.nil? && botToken != ""
            uri = URI("https://slack.com/api/chat.postMessage")
            payload.channel = targetChannel
            headers = {'Content-Type': 'application/json; charset=utf-8', 'Authorization': "Bearer #{botToken}"}
        else
            uri = URI(inCommingWebHookURL)
            payload.channel = nil
            headers = {'Content-Type': 'application/json; charset=utf-8'}
        end
        
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Post.new(uri.request_uri, headers)
        req.body = payload.to_json
        res = http.request(req)
        JSON.parse(res.body)
    end

    private
    class Payload
        attr_accessor :channel, :attachments
        class Attachment
            attr_accessor :pretext, :color, :fallback, :title, :text, :author_name, :footer
        
            def as_json(options={})
            {
                pretext: @pretext,
                color: @color,
                fallback: @fallback,
                title: @title,
                text: @text,
                author_name: @author_name,
                footer: @footer
            }
            end
    
            def to_json(*options)
                as_json(*options).to_json(*options)
            end
        end

        def as_json(options={})
        {
            channel: @channel,
            attachments: @attachments
        }
        end

        def to_json(*options)
            as_json(*options).to_json(*options)
        end
    end
end