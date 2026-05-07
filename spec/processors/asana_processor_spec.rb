require 'spec_helper'
require 'Processors/AsanaProcessor'

RSpec.describe AsanaProcessor do
    let(:base_path) { Fixtures.tmpdir }

    def base_cfg
        {
            "asanaToken"             => "xxx",
            "asanaProjectID"         => "PROJ1",
            "asanaTaskTitleTemplate" => "%TITLE%",
            "asanaTaskBodyTemplate"  => "%BODY%",
            "asanaTimeZoneOffset"    => "+00:00"
        }
    end

    def build(extra = {})
        AsanaProcessor.new(
            config: base_cfg.merge(extra),
            config_file_path: "/c.yml",
            base_execute_path: base_path
        )
    end

    it "creates a task per review and stores asanaTaskGID in tempData" do
        stub_request(:post, "https://app.asana.com/api/1.0/tasks")
            .to_return(status: 200, body: '{"data":{"gid":"TASK_1"}}')
        review = Fixtures.review
        build.process_reviews([review], "Apple")
        expect(review.tempData[AsanaProcessor::TEMPDATA_ASANA_TASK_GID]).to eq("TASK_1")
    end

    it "looks up sectionID and calls /sections/:id/addTask when asanaSectionName is set" do
        stub_request(:get, "https://app.asana.com/api/1.0/projects/PROJ1/sections")
            .to_return(status: 200, body: '{"data":[{"gid":"SEC1","name":"My Section"}]}')
        stub_request(:post, "https://app.asana.com/api/1.0/tasks")
            .to_return(status: 200, body: '{"data":{"gid":"T1"}}')
        addtask = stub_request(:post, "https://app.asana.com/api/1.0/sections/SEC1/addTask")
            .to_return(status: 200, body: '{"data":{}}')
        build("asanaSectionName" => "My Section").process_reviews([Fixtures.review], "Apple")
        expect(addtask).to have_been_requested
    end

    it "applies inclusion filters via the FilterableProcessor mixin" do
        stub_request(:post, "https://app.asana.com/api/1.0/tasks")
            .to_return(status: 200, body: '{"data":{"gid":"T1"}}')
        rs = [Fixtures.review(rating: 1), Fixtures.review(rating: 5)]
        build("ratingsInclude" => [5]).process_reviews(rs, "Apple")
        expect(WebMock).to have_requested(:post, "https://app.asana.com/api/1.0/tasks").once
    end

    it "sets due_at from createdDateTimestamp when present" do
        body_capture = nil
        stub_request(:post, "https://app.asana.com/api/1.0/tasks")
            .with do |req|
                body_capture = JSON.parse(req.body)
                true
            end
            .to_return(status: 200, body: '{"data":{"gid":"T1"}}')
        build.process_reviews([Fixtures.review(createdDateTimestamp: 0)], "Apple")
        expect(body_capture["data"]["due_at"]).to eq("1970-01-01T00:00:00+00:00")
    end

    it "is registered as AsanaProcessor and asana" do
        expect(ProcessorRegistry.lookup("AsanaProcessor")).to eq(AsanaProcessor)
        expect(ProcessorRegistry.lookup("asana")).to eq(AsanaProcessor)
    end
end
