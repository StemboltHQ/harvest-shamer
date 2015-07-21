class TimeTracker
  def initialize(date, subdomain, username, password)
    @date = date
    @subdomain = subdomain
    @username = username
    @password = password
    @hardy_client = get_hardy_client
  end

  def users
    harvest_users.map { |harvest_user| to_user(harvest_user) }
  end

  def entries(harvest_user)
    @hardy_client.time.all(@date, harvest_user)
  end

  def harvest_users
    begin
      @hardy_client.users.all
    rescue Harvest::NotFound
      Log.print "The credentials you have configured do not have administrative privileges, you can only access your timers"
      [current_harvest_user]
    end
  end

  def current_harvest_user
    Harvest::User.new(first_name: @username, last_name: "", email: @username)
  end

  def notifications
    entry_notifications + message_notifications
  end

  private

  def to_user(harvest_user)
    User.new(first_name: harvest_user.first_name, last_name: harvest_user.last_name, email: harvest_user.email, entries: entries(harvest_user))
  end

  def users_without_time_entries
    users.select { |user| user.missing_entries? }
  end

  def entry_notifications
    users_without_time_entries.map { |user| EntriesNotification.new(user, current_harvest_user) }
  end

  def users_missing_notes
    users.select { |user| user.missing_notes? }
  end

  def message_notifications
    users_missing_notes.map { |user| NotesNotification.new(user, current_harvest_user) }
  end

  def get_hardy_client
    Harvest.hardy_client(subdomain: @subdomain, username: @username, password: @password)
  end
end
