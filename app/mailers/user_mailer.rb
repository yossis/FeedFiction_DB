class UserMailer < ActionMailer::Base
  default from: "notifications@feedfiction.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome (user)
    @user = user
    mail to: user.email, subject: "Welocme to Feedfiction"
  end

  def continue_story(story , user, current_user)
    @story = story
    @current_user = current_user
    @user  = user
    mail to: user, subject: "#{current_user.name} continued your story"
    #emails = story.writers.map {|i| i.email}.compact
    #emails = emails.delete current_user.email if current_user.email.present?
  end
    
    
end
