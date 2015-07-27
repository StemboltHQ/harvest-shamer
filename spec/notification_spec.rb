require 'spec_helper'

RSpec.describe Notification do
  let(:notification) { Notification.new(recipient, sender, message) }

  let(:recipient) { User.new(email: "recipient@example.com") }
  let(:sender) { User.new(email: "sender@example.com") }
  let(:message) { "arbitrary message" }

  let(:notifier_double) { double("Slack::Notifier") }

  before(:each) do
    allow(Slack::Notifier).to receive(:new).and_return notifier_double
  end

  describe "#deliver" do
    subject { notification.deliver("test-key") }

    context "when recipient has a slack id" do
      before(:each) do
        allow(recipient).to receive(:slack_id).and_return "my_name"
      end

      it "sends a slack notification" do
        expect(notifier_double).to receive(:ping)
        subject
      end
    end

    context "when recipient does not have a slack id" do
      before(:each) do
        allow(recipient).to receive(:slack_id).and_return nil
      end

      it { should have_sent_email }
    end
  end
end
