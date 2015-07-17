require 'spec_helper'

RSpec.describe EntriesNotification do
  let(:entries_notif) { EntriesNotification.new(recipient, sender) }

  let(:recipient) { User.new(email: "recipient@example.com") }
  let(:sender) { User.new(email: "sender@example.com") }

  it "builds the message" do
    expect(entries_notif.message).not_to be_empty
  end
end
