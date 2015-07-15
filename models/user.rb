class User
  attr_accessor :first_name, :last_name, :email, :entries

  def initialize(params = {})
    @first_name = params[:first_name] || ""
    @last_name = params[:last_name] || ""
    @email = params[:email] || ""
    @entries = params[:entries] || []
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
end
