$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Models/WelcomeMessageCapable"
require "Helper"
require "ZLogger"
require "net/http"
require "json"
require "time"

class SlackProcessor < Processor
    include WelcomeMessageCapable

    register "slack"

    # tempData keys this processor produces.
    TEMPDATA_SLACK_TS         = "slackTS".freeze
    TEMPDATA_SLACK_CHANNEL_ID = "slackChannelID".freeze

    attr_accessor :botToken, :inCommingWebHookURL, :targetChannel, :timeZoneOffset, :attachmentGroupByNumber

    def validate_config!
        @botToken                = config["slackBotToken"]
        @inCommingWebHookURL     = config["slackInCommingWebHookURL"]
        @targetChannel           = config["slackBotTargetChannel"]
        @timeZoneOffset          = Helper.unwrapRequiredParameter(config, "slackTimeZoneOffset")
        @attachmentGroupByNumber = clamp_group_size(config["slackAttachmentGroupByNumber"])

        if blank?(@botToken) && blank?(@inCommingWebHookURL)
            raise "must specify slackBotToken or slackInCommingWebHookURL in SlackProcessor."
        elsif !blank?(@botToken) && blank?(@targetChannel)
            raise "must specify slackBotTargetChannel in SlackProcessor."
        end

        puts "[SlackProcessor] Init Success."
    end

    def process_reviews(reviews, platform)
        return reviews if reviews.empty?

        pendingRequests = []

        # Slack Message Limit: posting one message per second per channel
        reviews.each_slice(attachmentGroupByNumber) do |reviewGroup|
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

            pendingRequests.append({"payload" => payload, "reviewGroup" => reviewGroup})
        end

        loop do
            pendingRequest = pendingRequests.shift
            payload = pendingRequest["payload"]
            reviewGroup = pendingRequest["reviewGroup"]

            result = slack_request(payload)
            if !result[:ok]
                logger.logError(payload)
                logger.logError(result)
                if result[:message] == "ratelimited"
                    puts "[SlackProcessor] Reached Rate Limited, sleep 1 sec..."
                    sleep(1)
                    pendingRequests.insert(0, pendingRequest)
                end
            elsif !result[:ts].nil?
                reviewGroup.each do |review|
                    review.tempData[TEMPDATA_SLACK_TS]         = result[:ts]
                    review.tempData[TEMPDATA_SLACK_CHANNEL_ID] = targetChannel
                end
            end

            puts "[SlackProcessor] Send new Review messages, rest: #{pendingRequests.length}"
            break if pendingRequests.length < 1
        end

        reviews
    end

    def send_welcome_message(platform)
        payload = Payload.new()
        payload.attachments = []

        attachment = Payload::Attachment.new()
        title = "ZReviewTender Standing By :astronaut:"
        body  = "#{platform} Init Success!, will resend App Review to this channel automatically."

        attachment.color = "good"
        attachment.author_name = "ZhgChgLi"
        attachment.fallback = title
        attachment.title = title
        attachment.text = body
        attachment.footer = "<https://github.com/ZhgChgLi/ZReviewTender|ZReviewTender>, <https://github.com/ZhgChgLi/ZReviewTender/issues|Report an issue>, Powered by <https://zhgchg.li|ZhgChgLi>."

        payload.attachments.append(attachment)

        puts "[SlackProcessor] sendWelcomeMessage(#{title})"
        slack_request(payload)
    end
    alias_method :sendWelcomMessage, :send_welcome_message

    private

    def slack_request(payload)
        isInCommingWebHook = false
        if !blank?(botToken)
            uri = URI("https://slack.com/api/chat.postMessage")
            payload.channel = targetChannel
            headers = {'Content-Type': 'application/json; charset=utf-8', 'Authorization': "Bearer #{botToken}"}
            isInCommingWebHook = false
        else
            uri = URI(inCommingWebHookURL)
            payload.channel = nil
            headers = {'Content-Type': 'application/json; charset=utf-8'}
            isInCommingWebHook = true
        end

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Post.new(uri.request_uri, headers)
        req.body = payload.to_json
        res = http.request(req)

        if isInCommingWebHook
            return {"ok": res.body == "ok", "message": nil, "ts": res['ts']}
        else
            result = JSON.parse(res.body)
            return {"ok": result["ok"] == true, "message": result['error'], "ts": result['ts']}
        end
    end

    def blank?(s)
        s.nil? || s == ""
    end

    def clamp_group_size(value)
        return 1 if value.nil? || value == ""
        n = value.to_i
        n.between?(1, 99) ? n : 1
    end

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
