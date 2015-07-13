class TimeTracker
  def initialize(date, subdomain, username, password)
    @date = date
    @subdomain = subdomain
    @username = username
    @password = password
    @hardy_client = get_hardy_client
  end

  def users
    #TODO add UserList
  end

  def entries
    #TODO add EntryList
  end

  private

  def get_hardy_client
    Harvest.hardy_client(subdomain: @subdomain, username: @username, password: @password)
  end
end
