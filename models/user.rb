class User
  attr_accessor :first_name, :last_name, :email, :entries, :slack_id

  def initialize(params = {})
    @first_name = params[:first_name] || ""
    @last_name = params[:last_name] || ""
    @email = params[:email] || ""
    @entries = params[:entries] || []
    @slack_id = load_slack_id
  end

  def blank_entries
    entries.select { |entry| !entry.timer_started_at && entry.notes.empty? }
  end

  def missing_notes?
    !blank_entries.empty?
  end

  def missing_entries?
    entries.empty?
  end

  private

  def load_slack_id
    users = YAML::load_file('config/users.yml')
    users[email]
  end
end
