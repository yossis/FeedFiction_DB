class CustomRegistrationsController < ApplicationController
  def create
    #raise params[:story_line].to_yaml

    guest = User.get_guest(params[:user])
    if guest.login_count==0
    	UserMailer.delay.welcome(guest) if guest.email.present?
    end
    @story_line = StoryLine.create!(params[:story_line].merge user_id: guest.id , ip: request.remote_ip)
    
    @story_line.update_attribute(:line, until_55_words(@story_line.story,@story_line.line))

    #@story_line.save!
    @story = @story_line.story

    update_if_complete @story

    if @story.is_complete
      @invite_message = InviteText.rand_complete
    else
      @invite_message = InviteText.rand_continue
      @invisible = 'hide_action_hack'
    end
    redirect_to @story
    
  end


  def story
  	@story = Story.where("status=1 AND is_complete is null").order("RANDOM()").first
  end
end
