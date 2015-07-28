require 'spec_helper'

RSpec.describe SlackAPI do
  let(:slack_api) { SlackAPI.new("xxxxxxxxxxx") }

  let(:response) { { status: 200, body: json, headers: {} } }

  before(:each) do
    stub_request(:get, /https:\/\/slack.com\/api/).to_return response
  end

  describe "#users" do
    subject { slack_api.users }

    let(:json) { '{ "members": [{ "name": "bobby" }] }' }

    it "returns users" do
      expect(subject[0]["name"]).to eq "bobby"
    end
  end

  describe "#pair_with_harvest_users" do
    subject { slack_api.pair_with_harvest_users(harvest_users) }

    let(:harvest_user) { User.new(email: "test@test.com") }
    let(:harvest_users) { [harvest_user] }

    let(:json) { '{ "members": [{ "profile": { "email": "test@test.com" } }] }' }

    let(:expected_outcome) { { harvest_user => { "profile" => { "email" => "test@test.com" } } } }

    it "pairs the users" do
      expect(subject).to eq expected_outcome
    end
  end
end
