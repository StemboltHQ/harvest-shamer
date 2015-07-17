class EntriesNotification < Notification
  def initialize(recipient, sender)
    message = "You forgot to activate your timers today.\nPlease fix them immediately"
    super(recipient, sender, message)
  end
end
