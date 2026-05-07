require 'spec_helper'

RSpec.describe FilterableProcessor do
    let(:host_class) do
        Class.new do
            include FilterableProcessor
            attr_accessor :config
            def initialize(config); @config = config; end
        end
    end

    def host(cfg); host_class.new(cfg); end

    let(:reviews) do
        [
            Fixtures.review(rating: 5, territory: "TWN", body: "great app"),
            Fixtures.review(rating: 3, territory: "JPN", body: "okay"),
            Fixtures.review(rating: 1, territory: "USA", body: "bad app crash"),
            Fixtures.review(rating: 4, territory: nil,   body: nil)
        ]
    end

    it "returns input unchanged when all three lists are empty" do
        h = host({})
        expect(h.apply_inclusion_filters(reviews)).to eq(reviews)
    end

    it "filters by ratingsInclude (string and integer values both honored)" do
        h = host({"ratingsInclude" => ["5", 3]})
        expect(h.apply_inclusion_filters(reviews).map(&:rating)).to contain_exactly(5, 3)
    end

    it "filters by territoriesInclude case-insensitively" do
        h = host({"territoriesInclude" => ["twn", "jpn"]})
        expect(h.apply_inclusion_filters(reviews).map(&:territory)).to contain_exactly("TWN", "JPN")
    end

    it "applies AND semantics across multiple keywordsInclude" do
        h = host({"keywordsInclude" => ["app", "crash"]})
        expect(h.apply_inclusion_filters(reviews).map(&:body)).to eq(["bad app crash"])
    end

    it "ignores empty-string keywords" do
        h = host({"keywordsInclude" => ["", "great"]})
        expect(h.apply_inclusion_filters(reviews).map(&:body)).to eq(["great app"])
    end

    it "drops reviews with nil body when keyword filter is set" do
        h = host({"keywordsInclude" => ["app"]})
        result = h.apply_inclusion_filters(reviews)
        expect(result).not_to include(reviews.last)
    end

    it "drops reviews with nil territory when territory filter is set" do
        h = host({"territoriesInclude" => ["TWN"]})
        result = h.apply_inclusion_filters(reviews)
        expect(result).not_to include(reviews.last)
    end
end
