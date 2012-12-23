class RegisterController < ApplicationController
  before_filter :set_common_vars

  def start
    redirect_to root_url unless has_permission 
    end_wizard
    
    @title = 'Start your story'
    @next_step = find_friends_wizard_url
    @skip_next_text = 'Skip this step'
    @stories = Story.paginate(page: params[:page]).order('is_complete DESC,updated_at DESC')
  end

  def friends
    @title = 'Follow great people'
    @skip_next_text = "I'm done - start my feed fiction"
    @next_step = root_url
    @users = User.paginate(page: params[:page])
    
  end

  def facebook
    @images = Image.get_images(current_user, ImageType.facebook_id)
	end

  def instagram
    if (current_user.has_instagram?)
      @images = Image.get_images(current_user, ImageType.instagram_id)
      
    else
      redirect_to :controller => 'sessions', :action => 'connect_instagram' #if !session[:access_token] 
    end
  end

  def set_common_vars
    @title = 'Start your story'
    @skip_next_text = 'Skip this step'
    @next_step = find_friends_wizard_url
    @story = Story.new
  end

  private

  def has_permission
    return true if current_user.admin?
    return in_wizard
  end
end

