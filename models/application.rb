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

  def pull_user_data
    time_tracker = TimeTracker.new(Time.now, settings.harvest.subdomain, settings.harvest.username, settings.harvest.password)
    slack_api = SlackAPI.new(settings.slack.api_key)
    user_pairs = slack_api.pair_with_harvest_users(time_tracker.users)
    user_pairs.select! { |key, val| val }
    new_hash = {}
    user_pairs.each { |key, val| new_hash[key.email] = val["name"] }
    old_hash = YAML::load_file('config/users.yml')
    new_hash.merge!(old_hash)
    open('config/users.yml', 'w') do |file|
      file.puts new_hash.to_yaml
    end
  end
end
