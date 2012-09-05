class SessionsController < ApplicationController
  def create
  	#omniauth = request.env["omniauth.auth"]
    #raise omniauth.to_yaml
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user._id
    
    if user.first_time?
      start_wizard
      redirect_to start_story_wizard_url
    else
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private

    def start_wizard
     cookies[:register_wizard] = 1
    end
end