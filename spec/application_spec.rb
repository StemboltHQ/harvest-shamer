require 'spec_helper'

RSpec.describe Application do
  let(:application) { Application.new(settings) }
  let(:settings) { Settings.new("settings.yml") }
end
