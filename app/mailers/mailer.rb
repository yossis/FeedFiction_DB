class Mailer < ActionMailer::Base
  default from: "contactus@feedfiction.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #
  def invitation
    @greeting = "Hi"

    mail to: "to@example.org"
  end

 def contact_us(message)
    @message = message
    mail to: 'contactus@feedfiction.com' , from: @message.email , subject: "Contact - FeedFiction us message from #{message.name}"

  end

end
