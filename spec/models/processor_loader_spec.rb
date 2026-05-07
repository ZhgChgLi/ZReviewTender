require 'spec_helper'

RSpec.describe ProcessorLoader do
    let(:base_path) { Fixtures.tmpdir }

    # Build a self-contained Processor subclass under a unique constant so the
    # registry resolves it without us touching the real built-ins.
    def define_processor(name, &block)
        klass = Class.new(Processor) do
            class_eval(&block) if block
            def process_reviews(reviews, _platform); reviews; end
        end
        Object.const_set(name, klass) unless Object.const_defined?(name)
        ProcessorRegistry.register(name, klass)
        klass
    end

    before do
        @klass = define_processor("ZRTLoaderSpecP1") { attr_reader :payload; def validate_config!; @payload = config; end }
    end

    it "loads new flat 'type:' blocks" do
        blocks = [{"type" => "ZRTLoaderSpecP1", "enable" => true, "alpha" => 1}]
        result = ProcessorLoader.load(blocks, "/c.yml", base_path)
        expect(result.size).to eq(1)
        expect(result.first.payload).to eq({"alpha" => 1})
    end

    it "loads legacy {Klass: { class: ... }} blocks and emits a deprecation warning" do
        blocks = [{"ZRTLoaderSpecP1" => {"class" => "ZRTLoaderSpecP1", "enable" => true, "k" => "v"}}]
        expect {
            result = ProcessorLoader.load(blocks, "/c.yml", base_path)
            expect(result.size).to eq(1)
            expect(result.first.payload).to include("k" => "v")
        }.to output(/DEPRECATION/).to_stderr
    end

    it "skips blocks with enable: false" do
        blocks = [{"type" => "ZRTLoaderSpecP1", "enable" => false}]
        expect(ProcessorLoader.load(blocks, "/c.yml", base_path)).to be_empty
    end

    it "defaults enable to true when omitted in new format" do
        blocks = [{"type" => "ZRTLoaderSpecP1"}]
        expect(ProcessorLoader.load(blocks, "/c.yml", base_path).size).to eq(1)
    end

    it "raises a clear KeyError when type is unregistered" do
        blocks = [{"type" => "DoesNotExist", "enable" => true}]
        expect {
            ProcessorLoader.load(blocks, "/c.yml", base_path)
        }.to raise_error(KeyError, /No processor registered as 'DoesNotExist'/)
    end

    it "calls require for require: keys before lookup" do
        blocks = [{"type" => "ZRTLoaderSpecP1", "enable" => true, "require" => "no_such_path/_x"}]
        expect {
            ProcessorLoader.load(blocks, "/c.yml", base_path)
        }.to raise_error(/Failed to require external processor/)
    end

    it "rescues keyword-arg ArgumentError and falls back to positional initialize for legacy user processors" do
        legacy = Class.new do
            attr_reader :got_config, :got_path, :got_base
            def initialize(config, configFilePath, baseExecutePath)
                @got_config = config
                @got_path = configFilePath
                @got_base = baseExecutePath
            end
        end
        Object.const_set("LegacyKWLessProcessor", legacy)
        ProcessorRegistry.register("LegacyKWLessProcessor", legacy)
        blocks = [{"type" => "LegacyKWLessProcessor", "enable" => true, "x" => 1}]
        result = ProcessorLoader.load(blocks, "/c.yml", base_path)
        expect(result.first.got_config).to eq({"x" => 1})
        expect(result.first.got_path).to eq("/c.yml")
        expect(result.first.got_base).to eq(base_path)
    end

    it "raises when a block is not a mapping" do
        expect {
            ProcessorLoader.load([["not a hash"]], "/c.yml", base_path)
        }.to raise_error(/must be a mapping/)
    end
end
