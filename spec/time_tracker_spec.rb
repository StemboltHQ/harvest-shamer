require 'spec_helper'

RSpec.describe TimeTracker do
  let(:time_tracker) { described_class.new(Time.now, "testdomain", "testuser", "testpass") }

  let(:client_double) { double("Harvest::HardyClient") }
  let(:time_double) { double("Harvest::API::Time") }
  let(:users_double) { double("Harvest::API::Users") }

  before(:each) do
    allow(Harvest).to receive(:hardy_client).and_return client_double

    allow(client_double).to receive(:time).and_return time_double
    allow(client_double).to receive(:users).and_return users_double

    allow(time_double).to receive(:all).and_return [Harvest::TimeEntry.new]

    allow(users_double).to receive(:all).and_return [Harvest::User.new]
  end

  describe "#users" do
    subject { time_tracker.users }

    it "returns a list of users" do
      expect(subject).not_to be_empty
      expect(subject).to all be_a(User)
    end
  end

  describe "#entries" do
    subject { time_tracker.entries(Harvest::User.new) }

    it "returns a list of entries" do
      expect(subject).not_to be_empty
      expect(subject).to all be_a(Harvest::TimeEntry)
    end
  end

  describe "#harvest_users" do
    subject { time_tracker.harvest_users }

    context "with current user being admin" do
      it "returns all harvest users" do
        expect(subject).not_to be_empty
        expect(subject).to all be_a(Harvest::User)
      end
    end

    context "with current user not being admin" do
      before(:each) do
        allow(users_double).to receive(:all).and_raise(Harvest::NotFound, "")
      end

      it "returns the current user" do
        expect(subject.first).to have_attributes(first_name: "testuser", email: "testuser")
      end
    end
  end

  describe "#current_harvest_user" do
    subject { time_tracker.current_harvest_user }

    it "should return current user" do
      expect(subject).to have_attributes(first_name: "testuser", email: "testuser")
    end
  end
end
