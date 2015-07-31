require 'spec_helper'

RSpec.describe Settings do
  let(:test_settings) { Settings.new('') }

  let(:harvest_attributes) { { subdomain: "doe_industries", username: "janedoe@example.com", password: "password" } }
  let(:mailer_attributes) { { smtp: "smtp.example.com", smtp_port: 000, domain: "email.example.com", username: "janedoe@example.com", password: "password" } }

  it "assigns harvest settings" do
    expect(test_settings.harvest).to have_attributes(harvest_attributes)
  end

  it "assigns mailer settings" do
    expect(test_settings.mailer).to have_attributes(mailer_attributes)
  end
end
