require 'spec_helper'

RSpec.describe Notification do
  let(:notification) { Notification.new(recipient, sender, message) }

  let(:recipient) { User.new(email: "recipient@example.com") }
  let(:sender) { User.new(email: "sender@example.com") }
  let(:message) { "arbitrary message" }

  describe "#deliver" do
    subject { notification.deliver }

    it { should have_sent_email }
  end
end
