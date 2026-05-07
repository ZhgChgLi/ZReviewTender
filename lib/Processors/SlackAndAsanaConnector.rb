$lib = File.expand_path('../lib', File.dirname(__FILE__))

require "Models/Review"
require "Models/Processor"
require "Helper"
require "Processors/SlackProcessor"
require "Processors/AsanaProcessor"
require "net/http"
require "json"

# Connects Slack messages to Asana tasks bidirectionally.
# Reads tempData keys produced by SlackProcessor and AsanaProcessor — must
# therefore be ordered AFTER both of them in the YAML processors list.
class SlackAndAsanaConnector < Processor

    register "slack_and_asana_connector"

    ASANA_API_BASE = "https://app.asana.com/api/1.0".freeze

    attr_accessor :slackBotToken, :asanaToken

    def validate_config!
        @asanaToken    = Helper.unwrapRequiredParameter(config, "asanaToken")
        @slackBotToken = Helper.unwrapRequiredParameter(config, "slackBotToken")
        puts "[SlackAndAsanaConnector] Init Success."
    end

    def asanaAPIURL
        ASANA_API_BASE
    end

    def process_reviews(reviews, platform)
        return reviews if reviews.empty?

        # Step 1: post Slack permalink as a story comment on the Asana task.
        pendingReviews = reviews.dup
        loop do
            review = pendingReviews.shift

            result = slack_get_permalink(review)
            if !result["ok"]
                if result["error"] == "ratelimited"
                    puts "[SlackAndAsanaConnector] Reached Rate Limited, sleep 1 sec..."
                    sleep(1)
                    pendingReviews.insert(0, review)
                end
            else
                asana_post_story(review, "ref: #{result["permalink"]}")
            end

            puts "[SlackAndAsanaConnector] Connect Slack Message to Asana Task, rest: #{pendingReviews.length}"
            break if pendingReviews.length < 1
        end

        # Step 2: post Asana task URL as a Slack thread reply.
        pendingReviews = reviews.dup
        loop do
            review = pendingReviews.shift
            asanaTaskURL = retrieve_asana_task_url(review)
            unless asanaTaskURL.nil?
                result = slack_post_thread_reply(review, "<#{asanaTaskURL}| Go To *Asana Task*>")
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

        reviews
    end

    private

    def slack_channel_id(review)
        review.tempData[SlackProcessor::TEMPDATA_SLACK_CHANNEL_ID]
    end

    def slack_ts(review)
        review.tempData[SlackProcessor::TEMPDATA_SLACK_TS]
    end

    def asana_task_gid(review)
        review.tempData[AsanaProcessor::TEMPDATA_ASANA_TASK_GID]
    end

    def slack_get_permalink(review)
        uri = URI("https://slack.com/api/chat.getPermalink?channel=#{slack_channel_id(review)}&message_ts=#{slack_ts(review)}")
        headers = {'Content-Type': 'application/json; charset=utf-8', 'Authorization': "Bearer #{slackBotToken}"}

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Get.new(uri.request_uri, headers)
        res = http.request(req)
        JSON.parse(res.body)
    end

    def slack_post_thread_reply(review, message)
        payload = Payload.new()
        payload.text = message
        payload.channel = slack_channel_id(review)
        payload.thread_ts = slack_ts(review)
        payload.unfurl_links = true
        payload.unfurl_media = true

        uri = URI("https://slack.com/api/chat.postMessage")
        headers = {'Content-Type': 'application/json; charset=utf-8', 'Authorization': "Bearer #{slackBotToken}"}

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Post.new(uri.request_uri, headers)
        req.body = payload.to_json
        res = http.request(req)
        JSON.parse(res.body)
    end

    def retrieve_asana_task_url(review)
        gid = asana_task_gid(review)
        return nil if gid.nil? || gid == ""
        "https://app.asana.com/0/0/#{gid}/f"
    end

    def asana_post_story(review, message)
        gid = asana_task_gid(review)
        return nil if gid.nil? || gid == ""

        uri = URI("#{ASANA_API_BASE}/tasks/#{gid}/stories")
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(uri)
        request['Content-Type'] = 'application/json'
        request.body = JSON.dump({"data": {"text": message}})
        request['Authorization'] = "Bearer #{asanaToken}"

        response = https.request(request).read_body
        JSON.parse(response)
    end

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
