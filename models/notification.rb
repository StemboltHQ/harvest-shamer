class Notification
  attr_reader :recipient, :sender, :message

  def initialize(recipient, sender, message)
    @recipient = recipient
    @sender = sender
    @message = message
  end

  def deliver
    Log.print "emailing #{recipient.first_name} #{recipient.last_name}"

    Mail.new(
      from: sender.email,
      to: recipient.email,
      subject: 'Shame on you!',
      body: message
    ).deliver
  end
end
