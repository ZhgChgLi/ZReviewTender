require 'spec_helper'
require 'Processors/FilterProcessor'

RSpec.describe FilterProcessor do
    let(:base_path) { Fixtures.tmpdir }

    def build(cfg)
        FilterProcessor.new(config: cfg, config_file_path: "/c.yml", base_execute_path: base_path)
    end

    it "returns [] for empty input" do
        expect(build({}).process_reviews([], "Apple")).to eq([])
    end

    it "no-ops when no filters are configured" do
        rs = [Fixtures.review(rating: 1), Fixtures.review(rating: 5)]
        expect(build({}).process_reviews(rs, "Apple")).to eq(rs)
    end

    it "applies inclusion filters via the FilterableProcessor mixin" do
        rs = [
            Fixtures.review(rating: 5, territory: "TWN", body: "good"),
            Fixtures.review(rating: 1, territory: "JPN", body: "bad")
        ]
        result = build({"ratingsInclude" => [5]}).process_reviews(rs, "Apple")
        expect(result.map(&:rating)).to eq([5])
    end

    it "is registered under 'FilterProcessor' (legacy class name) and 'filter' (alias)" do
        expect(ProcessorRegistry.lookup("FilterProcessor")).to eq(FilterProcessor)
        expect(ProcessorRegistry.lookup("filter")).to eq(FilterProcessor)
    end
end
