require 'spec_helper'
require 'Processors/SlackProcessor'

RSpec.describe SlackProcessor do
    let(:base_path) { Fixtures.tmpdir }

    let(:bot_config) do
        {
            "slackBotToken"          => "xoxb-test",
            "slackBotTargetChannel"  => "C123",
            "slackTimeZoneOffset"    => "+08:00",
            "slackAttachmentGroupByNumber" => "1"
        }
    end

    def build(cfg)
        SlackProcessor.new(config: cfg, config_file_path: "/c.yml", base_execute_path: base_path)
    end

    it "raises when both bot token and webhook are blank" do
        expect {
            build({"slackTimeZoneOffset" => "+00:00"})
        }.to raise_error(/slackBotToken or slackInCommingWebHookURL/)
    end

    it "raises when bot token is set but channel is blank" do
        expect {
            build({"slackBotToken" => "x", "slackTimeZoneOffset" => "+00:00"})
        }.to raise_error(/slackBotTargetChannel/)
    end

    it "uses chat.postMessage when bot token present and writes ts/channel into tempData" do
        stub_request(:post, "https://slack.com/api/chat.postMessage")
            .to_return(status: 200, body: '{"ok":true,"ts":"123.456"}', headers: {"Content-Type" => "application/json"})
        review = Fixtures.review
        sp = build(bot_config)
        sp.process_reviews([review], "Apple")
        expect(review.tempData[SlackProcessor::TEMPDATA_SLACK_TS]).to eq("123.456")
        expect(review.tempData[SlackProcessor::TEMPDATA_SLACK_CHANNEL_ID]).to eq("C123")
    end

    it "uses incoming webhook URL when no bot token" do
        stub = stub_request(:post, "https://hooks.slack.com/services/AAA/BBB/CCC")
            .to_return(status: 200, body: "ok")
        cfg = {
            "slackInCommingWebHookURL" => "https://hooks.slack.com/services/AAA/BBB/CCC",
            "slackTimeZoneOffset"      => "+00:00"
        }
        build(cfg).process_reviews([Fixtures.review], "Apple")
        expect(stub).to have_been_requested
    end

    it "retries the same group on ratelimited and eventually succeeds" do
        sp = build(bot_config)
        # First call fails with ratelimited, second call succeeds.
        responses = [
            {status: 200, body: '{"ok":false,"error":"ratelimited"}'},
            {status: 200, body: '{"ok":true,"ts":"99.0"}'}
        ]
        stub_request(:post, "https://slack.com/api/chat.postMessage").to_return(*responses)
        allow(sp).to receive(:sleep)
        review = Fixtures.review
        sp.process_reviews([review], "Apple")
        expect(review.tempData[SlackProcessor::TEMPDATA_SLACK_TS]).to eq("99.0")
    end

    it "implements WelcomeMessageCapable#send_welcome_message and posts to Slack" do
        stub = stub_request(:post, "https://slack.com/api/chat.postMessage")
            .to_return(status: 200, body: '{"ok":true,"ts":"1.0"}')
        sp = build(bot_config)
        expect(sp).to be_a(WelcomeMessageCapable)
        sp.send_welcome_message("Apple")
        expect(stub).to have_been_requested
    end

    it "is registered under 'SlackProcessor' and 'slack'" do
        expect(ProcessorRegistry.lookup("SlackProcessor")).to eq(SlackProcessor)
        expect(ProcessorRegistry.lookup("slack")).to eq(SlackProcessor)
    end
end
