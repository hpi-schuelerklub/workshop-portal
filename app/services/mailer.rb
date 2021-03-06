class Mailer
  # @param hide_recipients - a boolean. `true` will send an email to the recipients one by one, `false` will send an email to all at once
  # @param recipients [Array<String>] - email addresses of recipients - can be a string of comma separated email adresses too
  # @param reply_to [Array<String>] - email addresses of recipient of the answer - can be a string of comma separated email adresses too
  # @param subject [String] - subject of the mail
  # @param content [String] - content of the mail
  # @param attachments array of hashes with name and content
  # @return [ActionMailer::MessageDelivery] a mail object with the given parameters.
  def self.send_generic_email(hide_recipients, recipients, reply_to, subject, content, attachments = [])
    if hide_recipients
      recipients = recipients.split(',') if recipients.is_a? String
      recipients.each do |recipient|
        PortalMailer.generic_email(recipient, reply_to, subject, content, attachments).deliver_now
      end
    else
      PortalMailer.generic_email(recipients, reply_to, subject, content, attachments).deliver_now
    end
  end
end
