require 'spec_helper'

RSpec.describe NotesNotification do
  let(:notes_notif) { NotesNotification.new(recipient, sender) }

  let(:recipient) { User.new(email: "recipient@example.com") }
  let(:sender) { User.new(email: "sender@example.com") }

  it "builds the message" do
    allow(recipient).to receive(:blank_entries).and_return []

    expect(notes_notif.message).not_to be_empty
  end
end
