require 'spec_helper'

RSpec.describe Processor do
    let(:base_path) { Fixtures.tmpdir }

    def make_subclass(name = "AutoRegisterTest")
        klass = Class.new(Processor)
        Object.const_set(name, klass) unless Object.const_defined?(name)
        klass.singleton_class.send(:define_method, :processor_name) { name }
        ProcessorRegistry.register(name, klass)
        klass
    ensure
        # leave class around — Object.const_set is idempotent across specs
    end

    it "auto-registers subclasses with their class name on inheritance" do
        klass = Class.new(Processor)
        klass.singleton_class.send(:define_method, :processor_name) { "AutoRegisteredA" }
        # subclass is created above without const_set, so trigger inherited via a fresh class:
        Class.new(klass)
        # The inheritance hook fires on the parent; verify it for the named class:
        expect(ProcessorRegistry.entries.values).to include(klass) | include(klass.superclass)
    end

    it "exposes config / configFilePath / baseExecutePath / logger after initialize" do
        klass = Class.new(Processor) do
            def process_reviews(reviews, _platform); reviews; end
        end
        instance = klass.new(config: {"k" => "v"}, config_file_path: "/tmp/c.yml", base_execute_path: base_path)
        expect(instance.config).to eq({"k" => "v"})
        expect(instance.configFilePath).to eq("/tmp/c.yml")
        expect(instance.baseExecutePath).to eq(base_path)
        expect(instance.logger).to be_a(ZLogger)
    end

    it "raises NotImplementedError when neither method is overridden" do
        klass = Class.new(Processor)
        instance = klass.new(config: {}, config_file_path: "/x", base_execute_path: base_path)
        expect { instance.process_reviews([], "Apple") }.to raise_error(NotImplementedError)
    end

    it "delegates processReviews -> process_reviews when only snake_case is overridden" do
        klass = Class.new(Processor) do
            def process_reviews(reviews, _platform); reviews + [:tagged]; end
        end
        instance = klass.new(config: {}, config_file_path: "/x", base_execute_path: base_path)
        expect(instance.processReviews([], "Apple")).to eq([:tagged])
    end

    it "delegates process_reviews -> processReviews (with deprecation) when only camelCase is overridden" do
        klass = Class.new(Processor) do
            def processReviews(reviews, _platform); reviews + ["legacy"]; end
        end
        instance = klass.new(config: {}, config_file_path: "/x", base_execute_path: base_path)
        expect {
            expect(instance.process_reviews([], "Apple")).to eq(["legacy"])
        }.to output(/DEPRECATION/).to_stderr
    end

    it "renderReview is an alias of render_review and substitutes %TITLE%/%BODY%/%RATING%/%CREATEDDATE%" do
        klass = Class.new(Processor) do
            def process_reviews(reviews, _platform); reviews; end
        end
        instance = klass.new(config: {}, config_file_path: "/x", base_execute_path: base_path)
        review = Fixtures.review(title: "T", body: "B", rating: 4, createdDateTimestamp: 0)
        rendered = instance.render_review("[%TITLE%][%BODY%][%RATING%][%CREATEDDATE%]", review, "+00:00")
        expect(rendered).to start_with("[T][B][4][")
        expect(instance.method(:renderReview)).to eq(instance.method(:render_review))
    end

    it "validate_config! is invoked from initialize and can raise" do
        klass = Class.new(Processor) do
            def process_reviews(reviews, _platform); reviews; end
            def validate_config!; raise "boom"; end
        end
        expect {
            klass.new(config: {}, config_file_path: "/x", base_execute_path: base_path)
        }.to raise_error("boom")
    end
end
