class SessionsController < ApplicationController
  def create
  	#omniauth = request.env["omniauth.auth"]
    #raise omniauth.to_yaml
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user._id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end