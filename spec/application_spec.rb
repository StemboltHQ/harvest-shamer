require 'spec_helper'

RSpec.describe Application do
  let(:application) { Application.new(settings) }
  let(:settings) { Settings.new("settings.yml") }

  describe "#shame_all" do
    subject { application.shame_all }

    it "starts a log entry" do
      expect(Log).to receive(:new_section)
      expect(Log).to receive(:print_date)
      subject
    end
  end
end
