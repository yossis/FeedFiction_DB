class SessionsController < ApplicationController
  def create
  	#omniauth = request.env["omniauth.auth"]
    #raise omniauth.to_yaml
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user._id
    cookies[:login] = { :value => user._id, :expires => 2.days.from_now }
    
    if user.first_time?
      UserMailer.delay.welcome(user) if user.email.present?
    end
    redirect_to general_feed_url
  end

  def destroy
    session[:user_id] = nil
    cookies.delete :login
    redirect_to root_url
  end


  def connect_instagram
    #logger.info '================================================>  in connect_instagram'
    redirect_to Instagram.authorize_url(:redirect_uri => ENV['INSTAGRAM_CALLBACK'])
  end

  def callback_instagram
    #logger.info '================================================>  in callback_instagram'
    response = Instagram.get_access_token(params[:code], :redirect_uri => ENV['INSTAGRAM_CALLBACK'])
    provider = Provider.set_provider('Instagram', response, current_user.id)
    session[:access_token] = provider.oauth_token
    session[:fire_insta_box]=1
     #logger.info "access-token:#{session[:access_token]}"

    if session[:is_from_ajax] == 1
      #logger.info '================================================>  in callback_instagram - has session - going to general feed to continue'
      session.delete :is_from_ajax
      redirect_to general_feed_url
    else
      #logger.info '================================================>  in callback_instagram - has session - going to get images'
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