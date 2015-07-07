class Settings
  attr_reader :harvest

  def initialize(path)
    @harvest = Settings::Harvest.new

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
end
