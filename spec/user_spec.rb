require 'spec_helper'

RSpec.describe User do
  let(:notes_entry) { double("Entry") }
  let(:empty_entry_running) { double("Entry") }
  let(:empty_entry) { double("Entry") }

  before(:each) do
    allow(notes_entry).to receive(:notes).and_return "some notes"
    allow(notes_entry).to receive(:timer_started_at).and_return nil
    allow(empty_entry).to receive(:notes).and_return ""
    allow(empty_entry).to receive(:timer_started_at).and_return nil
    allow(empty_entry_running).to receive(:notes).and_return ""
    allow(empty_entry_running).to receive(:timer_started_at).and_return "running"
  end

  describe "#blank_entries" do
    subject { user.blank_entries }

    let(:user) { User.new(entries: entries) }
    let(:entries) { [notes_entry, empty_entry, empty_entry_running] }

    it "returns entries without notes" do
      expect(subject).to match_array [empty_entry]
    end
  end

  describe "#missing_notes?" do
    subject { user.missing_notes? }

    let(:user) { User.new(entries: entries) }

    context "when user has blank entries" do
      let(:entries) { [empty_entry] }

      it { should be true }
    end

    context "when user has no blank entries" do
      let(:entries) { [notes_entry] }

      it { should be false }
    end
  end

  describe "#missing_entries?" do
    subject { user.missing_entries? }

    context "when user has no entries" do
      let(:user) { User.new }

      it { should be true }
    end

    context "when user has entries" do
      let(:user) { User.new(entries: entries) }
      let(:entries) { [notes_entry] }

      it { should be false }
    end
  end
end
