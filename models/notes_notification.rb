class NotesNotification < Notification
  def initialize(recipient, sender)
    message = build_message(recipient)
    super(recipient, sender, message)
  end

  private

  def build_message(user)
    message = "The following entries have no meaning:\n\n"
    user.blank_entries.each do |entry|
      message << "> #{entry.project} (#{entry.client}) at #{entry.timer_started_at}\n"
    end
    message
  end
end
