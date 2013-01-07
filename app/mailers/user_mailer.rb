class UserMailer < ActionMailer::Base
  #include Sidekiq::Mailer
  default from: "\"Feedfiction\" <notification@Feedfiction.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome (user)
    @user = user
    mail to: user.email, subject: "Welcome to FeedFiction"
  end

  def continue_story(story , user, current_user)
    @story = story
    @current_user = current_user
    @user  = user
    subject = "#{current_user.name} continued the story #{story.story_title}"
    subject = "#{current_user.name} continued your story #{story.story_title}" if story.user_id==user.id

    mail to: user.email, subject: subject
    #emails = story.writers.map {|i| i.email}.compact
    #emails = emails.delete current_user.email if current_user.email.present?
  end

  def comment_on_story(comment , user, current_user)
    @story = comment.story
    @current_user = current_user
    @user  = user
    @comment = comment

    mail to: user.email, subject: "#{current_user.name} commented on your story"
  end

  def like_story(story , user, current_user)
    @story = story
    @current_user = current_user
    subject = "#{current_user.name} likes the story #{story.story_title}"
    subject = "#{current_user.name} likes your story #{story.story_title}" if @story.user_id==user.id
    
    mail to: user.email, subject: subject
    
  end
    
    
end
