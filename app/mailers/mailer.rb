class Mailer < ActionMailer::Base
  default from: "contacts@feedfiction.com"

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
    mail to: 'contacts@feedfiction.com' , from: @message.email , subject: "Contact us message from #{message.name}"

  end

end
