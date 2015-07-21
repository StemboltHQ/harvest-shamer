require 'spec_helper'

RSpec.describe Application do
  let(:application) { Application.new(settings) }
  let(:settings) { Settings.new("settings.yml") }

  let(:time_tracker_double) { double("TimeTracker") }

  before(:each) do
    allow(TimeTracker).to receive(:new).and_return time_tracker_double
  end

  describe "#shame_all" do
    subject { application.shame_all }

    let(:notification) { double("Notification") }

    before(:each) do
      allow(time_tracker_double).to receive(:notifications).and_return [notification]
      allow(notification).to receive(:deliver)
    end

    it "starts a log entry" do
      expect(Log).to receive(:new_section)
      expect(Log).to receive(:print_date)
      subject
    end

    it "sends notifications" do
      expect(notification).to receive(:deliver)
      subject
    end
  end
end
