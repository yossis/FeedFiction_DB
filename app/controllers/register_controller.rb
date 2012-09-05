class RegisterController < ApplicationController
  def start
    #TODO: remove the cookie its just for example here
    cookies[:register_wizard] = '1'
    @title = 'Start your story'
    @next_step = find_friends_wizard_url
    @skip_next_text = 'Skip this step'
  end

  def friends
    @title = 'Follow great people'
    @skip_next_text = "I'm done - start my feed fiction"
    @next_step = root_url
    @users = User.paginate(page: params[:page])
    
  end

  def facebook
    @title = 'Start your story'
    @skip_next_text = 'Skip this step'
    @next_step = find_friends_wizard_url
  	#TODO: remove the duplicate code
    @images = Image.facebook_images(current_user)
	  @categories = Category.all
	  @story = Story.new
  	#render template: 'import_images/facebook'
  end

end

