require_relative 'spec_helper'

RSpec.describe Log do
  let(:log_file) { open("log.txt") }
  let!(:message) { "test" }

  shared_examples "an object that writes" do
    it "should write" do
      log_file.readlines #readlines sets pointer to end of file so only new lines will be read next time
      subject
      expect(log_file.readlines.size).to be > 0
    end
  end

  describe ".print" do
    subject { described_class.print(message) }

    it_behaves_like "an object that writes"

    context "when verbose" do
      before(:each) do
        Log.verbose = true
      end

      it "puts message to stdout" do
        expect($stdout).to receive(:puts).with(message)
        subject
      end
    end

    context "when not verbose" do
      before(:each) do
        Log.verbose = false
      end

      it "does not puts the message to stdout" do
        expect($stdout).not_to receive(:puts)
        subject
      end
    end
  end

  describe ".print_date" do
    subject { described_class.print_date }

    it_behaves_like "an object that writes"
  end

  describe ".new_section" do
    subject { described_class.new_section }

    it_behaves_like "an object that writes"
  end
end
