class SessionsController < ApplicationController
  def create
  	#omniauth = request.env["omniauth.auth"]
    #raise omniauth.to_yaml
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user._id
    
    if user.first_time?
      UserMailer.welcome(user).deliver if user.email.present?
    end
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end


  def connect_instagram
    redirect_to Instagram.authorize_url(:redirect_uri => ENV['INSTAGRAM_CALLBACK'])
  end

  def callback_instagram
    
    response = Instagram.get_access_token(params[:code], :redirect_uri => ENV['INSTAGRAM_CALLBACK'])
    provider = Provider.set_provider('Instagram', response, current_user.id)
    session[:access_token] = provider.oauth_token

    if session[:fire_insta_box] == 1
      redirect_to root_url
    else
      redirect_to instagram_images_url
    end

    
    # if current_user.first_time?
    #   redirect_to import_instagram_wizard_url
    # else
    #   redirect_to instagram_images_url
    # end
  end

  private

    def start_wizard
     cookies[:register_wizard] = 1
    end
end