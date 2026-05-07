require 'spec_helper'
require 'Processors/GoogleSheetProcessor'

RSpec.describe GoogleSheetProcessor do
    let(:base_path) { Fixtures.tmpdir }
    let(:fake_google_api) { instance_double("GoogleAPI") }

    def base_cfg
        {
            "googleSheetAPIKeyFilePath" => "/tmp/fake.json",
            "googleSheetTimeZoneOffset" => "+00:00",
            "googleSpreadsheetID"       => "SHEET_ID",
            "values"                    => ["%RATING%", "%TITLE%"]
        }
    end

    def build(extra)
        allow(GoogleAPI).to receive(:new).and_return(fake_google_api)
        cfg = base_cfg.merge(extra)
        GoogleSheetProcessor.new(config: cfg, config_file_path: "/c.yml", base_execute_path: base_path)
    end

    it "raises when googleSheetInsertStyle is not an array" do
        expect {
            build("googleSheetInsertStyle" => {"type" => "append"})
        }.to raise_error(/must specify as Array/)
    end

    it "calls values:append when type=append" do
        gs = build("googleSheetInsertStyle" => [{"type" => "append"}, {"sheetName" => "Sheet1"}])
        expect(fake_google_api).to receive(:request).with(
            a_string_matching(%r{/values/Sheet1!A1:append}), "POST", hash_including(:values)
        )
        gs.process_reviews([Fixtures.review(rating: 5, title: "T")], "Apple")
    end

    it "calls batchUpdate with insert payload when type=insert" do
        gs = build("googleSheetInsertStyle" => [{"type" => "insert"}, {"at" => 0}, {"sheetID" => 42}])
        expect(fake_google_api).to receive(:request).with(
            a_string_matching(/:batchUpdate/), "POST",
            hash_including(:requests)
        )
        gs.process_reviews([Fixtures.review], "Apple")
    end

    it "applies inclusion filters before formatting rows" do
        gs = build(
            "googleSheetInsertStyle" => [{"type" => "append"}, {"sheetName" => "S"}],
            "ratingsInclude" => [5]
        )
        rs = [Fixtures.review(rating: 1), Fixtures.review(rating: 5)]
        expect(fake_google_api).to receive(:request) do |_url, _method, payload|
            expect(payload[:values].size).to eq(1)
        end
        gs.process_reviews(rs, "Apple")
    end

    it "paginates writes in 100-row chunks" do
        gs = build("googleSheetInsertStyle" => [{"type" => "append"}, {"sheetName" => "S"}])
        reviews = Array.new(150) { |i| Fixtures.review(id: "r#{i}") }
        expect(fake_google_api).to receive(:request).twice
        gs.process_reviews(reviews, "Apple")
    end

    it "is registered as GoogleSheetProcessor and google_sheet" do
        expect(ProcessorRegistry.lookup("GoogleSheetProcessor")).to eq(GoogleSheetProcessor)
        expect(ProcessorRegistry.lookup("google_sheet")).to eq(GoogleSheetProcessor)
    end
end
