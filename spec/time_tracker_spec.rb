require 'spec_helper'

RSpec.describe TimeTracker do
  let!(:time_tracker) { described_class.new(Time.now, "testdomain", "testuser", "testpass") }

  describe "#users" do
    #to implement
  end

  describe "#entries" do
    #to implement
  end
end
