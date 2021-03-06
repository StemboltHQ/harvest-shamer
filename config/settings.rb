class Settings
  attr_reader :harvest, :mailer

  def initialize(path)
    @harvest = Settings::Harvest.new
    @mailer = Settings::Mailer.new

    hash = YAML::load_file(path)
    hash.each do |settings_key, settings_value|
      sub_settings = self.send(settings_key)

      settings_value.each do |key, value|
        sub_settings.send("#{key}=", value)
      end
    end
  end

  class Harvest
    attr_accessor :username, :password, :subdomain
  end

  class Mailer
    attr_accessor :smtp, :smtp_port, :from_name, :from_email, :domain, :username, :password
  end
end
