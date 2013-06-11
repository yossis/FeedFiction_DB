class AuthenticationsController < Devise::OmniauthCallbacksController
	def all

    auth = request.env["omniauth.auth"]
    # raise omniauth.to_yaml
    # user = User.from_omniauth(env["omniauth.auth"])
    # session[:user_id] = user._id
    # cookies[:login] = { :value => user._id, :expires => 2.days.from_now }
    
    # if user.first_time?
    #   UserMailer.delay.welcome(user) if user.email.present?
    # end
    # redirect_to general_feed_url
     # Try to find authentication first
	  #authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
	  user = User.from_omniauth(request.env["omniauth.auth"])
	  if user.persisted?
      flash.notice = "Signed in!"
      if user.first_time?
        UserMailer.delay.welcome(user) if user.email.present?
      end
      session["devise.user_attributes"] = nil
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end

  end
  alias_method :twitter ,:all

  def facebook
  	all
  end

  def create
  	
  end

  def destroy
  end
end
