class Application
  attr_reader :settings

  def initialize(settings)
    @settings = settings
    Log.verbose = true
    Log.file = 'log.txt'
    Mail.defaults do
      delivery_method :smtp,
        address: settings.mailer.smtp,
        port: settings.mailer.smtp_port,
        domain: settings.mailer.domain,
        user_name: settings.mailer.username,
        password: settings.mailer.password,
        authentication: 'plain',
        enable_starttls_auto: true
    end
  end

  def shame_all
    Log.new_section
    Log.print_date
    time_tracker = TimeTracker.new(Time.now, settings.harvest.subdomain, settings.harvest.username, settings.harvest.password)
    time_tracker.notifications.each do |notification|
      notification.deliver(settings.slack.webhook_url)
    end
  end
end
