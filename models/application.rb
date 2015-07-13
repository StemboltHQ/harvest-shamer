class Application
  attr_reader :settings

  def initialize(settings)
    @settings = settings
  end

  def shame_all
    time_tracker = TimeTracker.new(Time.now, settings.harvest.subdomain, settings.harvest.username, settings.harvest.password)
  end
end
