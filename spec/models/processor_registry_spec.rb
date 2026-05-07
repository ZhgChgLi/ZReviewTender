require 'spec_helper'

RSpec.describe ProcessorRegistry do
    let(:dummy) { Class.new }
    let(:other) { Class.new }

    it "registers and looks up by string name" do
        ProcessorRegistry.register("X", dummy)
        expect(ProcessorRegistry.lookup("X")).to eq(dummy)
    end

    it "lookup! raises KeyError for unknown name" do
        expect { ProcessorRegistry.lookup!("ghost") }.to raise_error(KeyError)
    end

    it "warns and overwrites when re-registering a name with a different class" do
        ProcessorRegistry.register("Y", dummy)
        expect { ProcessorRegistry.register("Y", other) }.to output(/being re-registered/).to_stderr
        expect(ProcessorRegistry.lookup("Y")).to eq(other)
    end

    it "does not warn on idempotent re-registration of the same class" do
        ProcessorRegistry.register("Z", dummy)
        expect { ProcessorRegistry.register("Z", dummy) }.not_to output.to_stderr
    end

    it "is reset! between specs (verified by lookup of fresh name)" do
        expect(ProcessorRegistry.lookup("__only_this_spec__")).to be_nil
        ProcessorRegistry.register("__only_this_spec__", dummy)
        expect(ProcessorRegistry.lookup("__only_this_spec__")).to eq(dummy)
    end

    it "treats names case-sensitively" do
        ProcessorRegistry.register("Foo", dummy)
        expect(ProcessorRegistry.lookup("foo")).to be_nil
    end
end
