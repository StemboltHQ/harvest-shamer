class SlackAPI
  BASE_URL = "https://slack.com/api"

  attr_reader :api_key

  def initialize(api_key)
    @api_key = api_key
  end

  def users
    request = Request.new(request_url("users.list"))
    response = request.get
    json_object = JObject.parse(response)
    json_object.members.select { |user| user.profile.respond_to?(:email) }
  end

  def pair_with_harvest_users(harvest_users)
    harvest_users.inject({}) do |hash, harvest_user|
      matching_user = users.select { |slack_user| slack_user.profile.email == harvest_user.email }.first
      hash[harvest_user] = matching_user
      hash
    end
  end

  private

  def request_url(method)
    BASE_URL + "/" + method + "?token=" + api_key
  end
end
