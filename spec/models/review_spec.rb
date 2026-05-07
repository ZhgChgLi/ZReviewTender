require 'spec_helper'

RSpec.describe Review do
    it "stores all attributes including tempData" do
        r = Fixtures.review
        expect(r.platform).to eq("iOS")
        expect(r.id).to eq("abc")
        expect(r.userName).to eq("alice")
        expect(r.rating).to eq(5)
        expect(r.title).to eq("great")
        expect(r.body).to eq("love it")
        expect(r.createdDateTimestamp).to eq(1_700_000_000)
        expect(r.url).to eq("http://example.com/r")
        expect(r.appVersion).to eq("1.0")
        expect(r.territory).to eq("TWN")
        expect(r.tempData).to eq({})
    end

    it "tempData is a mutable hash" do
        r = Fixtures.review
        r.tempData["k"] = 1
        expect(r.tempData).to eq({"k" => 1})
    end

    it "accepts nil title (Android case)" do
        r = Fixtures.review(title: nil)
        expect(r.title).to be_nil
    end
end
