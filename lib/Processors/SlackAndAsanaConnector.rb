$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Helper"
require "pathname"
require "GoogleAPI"

class SlackAndAsanaConnector < Processor

    attr_accessor :logger, :slackBotToken, :asanaToken, :projectID, :asanaAPIURL

    def initialize(config, configFilePath, baseExecutePath)
        @config = config
        @configFilePath = configFilePath
        @baseExecutePath = baseExecutePath
        @logger = ZLogger.new(baseExecutePath)

        @asanaAPIURL = "https://app.asana.com/api/1.0"
        @asanaToken = Helper.unwrapRequiredParameter(config, "asanaToken")
        @slackBotToken = Helper.unwrapRequiredParameter(config, "slackBotToken")

        puts "[SlackAndAsanaConnector] Init Success."
    end

    def processReviews(reviews, platform)        
        if reviews.length < 1
            return reviews
        end

        pendingReviews = reviews.dup

        loop do
            review = pendingReviews.shift

            result =  retrieveSlackMessage(review)
            if !result["ok"]
                if result["error"] == "ratelimited"
                    puts "[SlackAndAsanaConnector] Reached Rate Limited, sleep 1 sec..."
                    sleep(1)
                    pendingReviews.insert(0, review)
                end
            else
                sendAsanaCommentMessage(review, "ref: #{result["permalink"]}")
            end

            puts "[SlackAndAsanaConnector] Connect Slack Message to Asana Task, rest: #{pendingReviews.length}"
            break if pendingReviews.length < 1
        end

        pendingReviews = reviews.dup

        loop do
            review = pendingReviews.shift
            asanaTaskURL = retrieveAsanaTaskURL(review)
            if !asanaTaskURL.nil?
                result =  sendSlackCommnetMessage(review, "<#{asanaTaskURL}| Go To *Asana Task*>")
                if !result["ok"]
                    if result["error"] == "ratelimited"
                        puts "[SlackAndAsanaConnector] Reached Rate Limited, sleep 1 sec..."
                        sleep(1)
                        pendingReviews.insert(0, review)
                    end
                end
            end

            puts "[SlackAndAsanaConnector] Connect Asana Task to Slack Message, rest: #{pendingReviews.length}"
            break if pendingReviews.length < 1
        end

        return reviews
    end

    private
    def retrieveSlackMessage(review)
        uri = URI("https://slack.com/api/chat.getPermalink?channel=#{review.tempData["slackChannelID"]}&message_ts=#{review.tempData["slackTS"]}")
        headers = {'Content-Type': 'application/json; charset=utf-8', 'Authorization': "Bearer #{slackBotToken}"}
        
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Get.new(uri.request_uri, headers)
        res = http.request(req)

        result = JSON.parse(res.body)
        return result
    end

    private
    def sendSlackCommnetMessage(review, message)
        payload = Payload.new()
        payload.text = message
        payload.channel = review.tempData["slackChannelID"]
        payload.thread_ts = review.tempData["slackTS"]
        payload.unfurl_links = true
        payload.unfurl_media = true
        uri = URI("https://slack.com/api/chat.postMessage")
        headers = {'Content-Type': 'application/json; charset=utf-8', 'Authorization': "Bearer #{slackBotToken}"}
        
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Post.new(uri.request_uri, headers)
        req.body = payload.to_json
        res = http.request(req)

        result = JSON.parse(res.body)
        return result
    end


    private
    def retrieveAsanaTaskURL(review)
        if review.tempData["asanaTaskGID"].nil? || review.tempData["asanaTaskGID"] == ""
            return nil
        end

        return "https://app.asana.com/0/0/#{review.tempData["asanaTaskGID"]}/f"
    end

    private
    def sendAsanaCommentMessage(review, message)
        if review.tempData["asanaTaskGID"].nil? || review.tempData["asanaTaskGID"] == ""
            return nil
        end

        path = "/tasks/#{review.tempData["asanaTaskGID"]}/stories"
        uri = URI(asanaAPIURL+path)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        
        request = Net::HTTP::Post.new(uri)
        request['Content-Type'] = 'application/json'
        request.body = JSON.dump({"data": {"text": message}})
        
        request['Authorization'] = "Bearer #{asanaToken}"
        
        response = https.request(request).read_body

        return result = JSON.parse(response)
    end

    private
    class Payload
        attr_accessor :channel, :thread_ts, :text, :unfurl_links, :unfurl_media

        def as_json(options={})
        {
            channel: @channel,
            thread_ts: @thread_ts,
            text: @text,
            unfurl_links: @unfurl_links,
            unfurl_media: @unfurl_media
        }
        end

        def to_json(*options)
            as_json(*options).to_json(*options)
        end
    end
end