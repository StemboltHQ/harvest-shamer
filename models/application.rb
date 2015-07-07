class Application
  attr_reader :settings

  def initialize(settings)
    @settings = settings
    Log.verbose = true
    Log.file = 'log.txt'
  end

  def shame_all
    Log.new_section
    Log.print_date
    time_tracker = TimeTracker.new(Time.now, settings.harvest.subdomain, settings.harvest.username, settings.harvest.password)
  end
end
