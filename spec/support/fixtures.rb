module Fixtures
    def self.review(overrides = {})
        defaults = {
            platform: "iOS",
            id: "abc",
            userName: "alice",
            rating: 5,
            title: "great",
            body: "love it",
            createdDateTimestamp: 1_700_000_000,
            url: "http://example.com/r",
            appVersion: "1.0",
            territory: "TWN",
            tempData: {}
        }
        d = defaults.merge(overrides)
        Review.new(
            d[:platform], d[:id], d[:userName], d[:rating], d[:title], d[:body],
            d[:createdDateTimestamp], d[:url], d[:appVersion], d[:territory], d[:tempData]
        )
    end

    def self.tmpdir
        @tmpdir ||= Dir.mktmpdir("zrt-spec")
    end
end
