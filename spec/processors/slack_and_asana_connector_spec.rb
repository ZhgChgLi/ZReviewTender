require 'spec_helper'
require 'Processors/SlackProcessor'
require 'Processors/AsanaProcessor'
require 'Processors/SlackAndAsanaConnector'

RSpec.describe SlackAndAsanaConnector do
    let(:base_path) { Fixtures.tmpdir }

    def build
        SlackAndAsanaConnector.new(
            config: {"asanaToken" => "A", "slackBotToken" => "S"},
            config_file_path: "/c.yml",
            base_execute_path: base_path
        )
    end

    def review_with_links(slackTS: "1.0", channel: "C1", taskGID: "T1")
        r = Fixtures.review
        r.tempData[SlackProcessor::TEMPDATA_SLACK_TS]         = slackTS
        r.tempData[SlackProcessor::TEMPDATA_SLACK_CHANNEL_ID] = channel
        r.tempData[AsanaProcessor::TEMPDATA_ASANA_TASK_GID]   = taskGID
        r
    end

    it "calls chat.getPermalink and posts an Asana story per review" do
        permalink = stub_request(:get, %r{slack\.com/api/chat\.getPermalink})
            .to_return(status: 200, body: '{"ok":true,"permalink":"https://slack/p/1"}')
        story = stub_request(:post, "https://app.asana.com/api/1.0/tasks/T1/stories")
            .to_return(status: 200, body: '{"data":{}}')
        thread = stub_request(:post, "https://slack.com/api/chat.postMessage")
            .to_return(status: 200, body: '{"ok":true}')
        build.process_reviews([review_with_links], "Apple")
        expect(permalink).to have_been_requested
        expect(story).to have_been_requested
        expect(thread).to have_been_requested
    end

    it "skips Asana posting when asanaTaskGID is missing" do
        stub_request(:get, %r{slack\.com/api/chat\.getPermalink})
            .to_return(status: 200, body: '{"ok":true,"permalink":"https://slack/p/1"}')
        no_story = stub_request(:post, %r{app\.asana\.com/api/1\.0/tasks/.+/stories})
        build.process_reviews([review_with_links(taskGID: nil)], "Apple")
        expect(no_story).not_to have_been_requested
    end

    it "retries getPermalink on ratelimited" do
        sc = build
        allow(sc).to receive(:sleep)
        stub_request(:get, %r{slack\.com/api/chat\.getPermalink}).to_return(
            {status: 200, body: '{"ok":false,"error":"ratelimited"}'},
            {status: 200, body: '{"ok":true,"permalink":"https://slack/p/2"}'}
        )
        stub_request(:post, %r{app\.asana\.com/api/1\.0/tasks/.+/stories})
            .to_return(status: 200, body: '{"data":{}}')
        stub_request(:post, "https://slack.com/api/chat.postMessage")
            .to_return(status: 200, body: '{"ok":true}')
        sc.process_reviews([review_with_links], "Apple")
        expect(WebMock).to have_requested(:get, %r{chat\.getPermalink}).twice
    end

    it "is registered as SlackAndAsanaConnector and slack_and_asana_connector" do
        expect(ProcessorRegistry.lookup("SlackAndAsanaConnector")).to eq(SlackAndAsanaConnector)
        expect(ProcessorRegistry.lookup("slack_and_asana_connector")).to eq(SlackAndAsanaConnector)
    end
end
