class Notification
  attr_reader :recipient, :sender, :message

  def initialize(recipient, sender, message)
    @recipient = recipient
    @sender = sender
    @message = message
  end

  def deliver(webhook_url)
    if recipient.slack_id
      slack(webhook_url)
      Log.print "notified #{recipient.slack_id}"
    else
      Log.print "no slack_id could be found for #{recipient.email}, emailing instead"
      email
    end
  end

  private

  def slack(webhook_url)
    notifier = Slack::Notifier.new(webhook_url, {
      channel: "@#{recipient.slack_id}",
      username: "Harvest Shamer",
      icon_emoji: ":thumbsdown:"
    })
    notifier.ping message
  end

  def email
    Mail.new(
      from: sender.email,
      to: recipient.email,
      subject: 'Shame on you!',
      body: message
    ).deliver
  end
end
