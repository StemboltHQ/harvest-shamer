require 'spec_helper'

RSpec.describe Request do
  let(:request) { Request.new("http://www.test.com/api?token=xxxxx") }

  describe "#uri" do
    subject { request.uri }

    it "returns a uri for the url" do
      expect(subject.class).to eq URI::HTTP
      expect(subject).to have_attributes(host: "www.test.com", path: "/api", query: "token=xxxxx")
    end
  end

  describe "#get" do
    subject { request.get }

    let(:response) { { status: 200, body: "test response", headers: {} } }

    before(:each) do
      stub_request(:get, /www\.test\.com/).to_return(response)
    end

    it { is_expected.to eq response[:body] }
  end
end
