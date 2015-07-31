require_relative 'spec_helper'

RSpec.describe Log do
  let(:log_file) { open(Log.file) }

  let!(:message) { "test" }

  shared_examples "an object that writes" do
    it "should write" do
      subject
      expect(log_file.readlines).not_to be_empty
    end
  end

  shared_examples "an object that does not write" do
    it "should not write" do
      subject
      expect(log_file.readlines).to be_empty
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

    context "when file is empty" do
      it_behaves_like "an object that does not write"
    end

    context "when file has other entries" do
      before(:each) do
        open(Log.file, 'w') do |file|
          file.puts "entry"
        end
      end

      it_behaves_like "an object that writes"
    end
  end
end
