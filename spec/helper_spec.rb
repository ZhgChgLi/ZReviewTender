require 'spec_helper'

RSpec.describe Helper do
    describe ".unwrapRequiredParameter" do
        it "returns the value when present" do
            expect(Helper.unwrapRequiredParameter({"k" => "v"}, "k")).to eq("v")
        end

        it "raises when the key is missing" do
            expect { Helper.unwrapRequiredParameter({}, "k") }.to raise_error(/Required Parameter Not Found/)
        end

        it "raises when the value is an empty string" do
            expect { Helper.unwrapRequiredParameter({"k" => ""}, "k") }.to raise_error(/Required Parameter Is Empty/)
        end
    end

    describe ".createDirIfNotExist" do
        it "creates nested directories" do
            base = Dir.mktmpdir("zrt-helper")
            target = File.join(base, "a/b/c")
            Helper.createDirIfNotExist(target)
            expect(Dir.exist?(target)).to eq(true)
        end
    end
end
