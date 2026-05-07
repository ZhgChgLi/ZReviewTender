require 'spec_helper'
require 'Processors/GoogleTranslateProcessor'

RSpec.describe GoogleTranslateProcessor do
    let(:base_path) { Fixtures.tmpdir }

    # Bypass GoogleAPI's real init (which reads a JSON key file + does JWT
    # exchange) by stubbing the GoogleAPI constructor.
    let(:fake_google_api) { instance_double("GoogleAPI") }

    def build(cfg)
        allow(GoogleAPI).to receive(:new).and_return(fake_google_api)
        GoogleTranslateProcessor.new(
            config: cfg.merge("googleTranslateAPIKeyFilePath" => "/tmp/fake.json", "googleTranslateTargetLang" => "zh-TW"),
            config_file_path: "/c.yml", base_execute_path: base_path
        )
    end

    it "skips reviews whose territory is in territoriesExclude" do
        gt = build("googleTranslateTerritoriesExclude" => ["TWN"])
        review = Fixtures.review(territory: "TWN", title: "hi", body: "hi")
        expect(fake_google_api).not_to receive(:request)
        gt.process_reviews([review], "Apple")
        expect(review.title).to eq("hi")
    end

    it "rewrites title and body when translation differs" do
        gt = build({})
        review = Fixtures.review(title: "Hello", body: "World", territory: "USA")
        allow(fake_google_api).to receive(:request).and_return(
            {"data" => {"translations" => [{"translatedText" => "你好"}]}},
            {"data" => {"translations" => [{"translatedText" => "世界"}]}}
        )
        gt.process_reviews([review], "Apple")
        expect(review.title).to eq("你好 (Hello)")
        expect(review.body).to start_with("世界")
        expect(review.body).to include("===== Translate by Google =====")
        expect(review.body).to end_with("World")
    end

    it "leaves title untouched when translation equals the original" do
        gt = build({})
        review = Fixtures.review(title: "Hi", body: "Hi", territory: "USA")
        allow(fake_google_api).to receive(:request).and_return(
            {"data" => {"translations" => [{"translatedText" => "Hi"}]}},
            {"data" => {"translations" => [{"translatedText" => "Hi"}]}}
        )
        gt.process_reviews([review], "Apple")
        expect(review.title).to eq("Hi")
        expect(review.body).to eq("Hi")
    end

    it "handles nil title (Android case) without raising" do
        gt = build({})
        review = Fixtures.review(title: nil, body: "hello", territory: "USA")
        allow(fake_google_api).to receive(:request).and_return(
            {"data" => {"translations" => [{"translatedText" => "你好"}]}}
        )
        expect { gt.process_reviews([review], "Android") }.not_to raise_error
        expect(review.body).to start_with("你好")
    end

    it "is registered as GoogleTranslateProcessor and google_translate" do
        expect(ProcessorRegistry.lookup("GoogleTranslateProcessor")).to eq(GoogleTranslateProcessor)
        expect(ProcessorRegistry.lookup("google_translate")).to eq(GoogleTranslateProcessor)
    end
end
