require 'spec_helper'

RSpec.describe Settings do
  let(:test_settings) { Settings.new('') }
  let(:test_yaml) { "harvest:\n  username: test" }

  before(:each) do
    allow(YAML).to receive(:load_file).and_return(YAML::load(test_yaml))
  end

  describe "#initialize" do
    subject { test_settings }

    it "assigns attributes to settings classes" do
      expect(subject.harvest.username).to eq "test"
    end
  end
end
