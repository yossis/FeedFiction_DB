class ApplicationController < ActionController::Base
  protect_from_forgery
  #http_basic_authenticate_with :name => "frodo", :password => "thering"
  # before_filter :authenticate 
  before_filter :ie_disclaimer ,:detect_facebook_post!


  private

  def current_user_was_and_log_out
    if current_user.nil? && cookies[:login]
      redirect_to '/auth/facebook'
    end
  end

  def detect_facebook_post!
    if request.params['signed_request']
      if current_user.nil? 
        redirect_to "/auth/facebook"
      else
        reconnect_with_facebook
      end
      #if session[:user_id].nil? || 
      #check if user connect

      #redirect_to '/auth/facebook'
    end
    #TODO: check cookie expires and redirect if has
    true
  end

  def reconnect_with_facebook
    if current_user && current_user.fb_token_expired?

      # re-request a token from facebook. Assume that we got a new token so
      # update it anyhow...
      session[:return_to] = request.env["REQUEST_URI"] unless request.env["REQUEST_URI"] == facebook_request_path
      redirect_to(with_canvas(facebook_request_path)) and return false
    end
  end

  
  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
  helper_method :mobile_device?
  

  def authenticate
    # if Rails.env.production? 
    #   authenticate_or_request_with_http_basic do |username, password|
    #     username == "foo" && password == "bar"
    #   #    u = Account.authorize(username,password)
    #   #    u.present?
    #   end 
    # end
  end


  def ie_disclaimer
    if Rails.env.production? 
        if params[:debug]=='true'
          session[:ie] = 1
        redirect_to root_url
      else
        redirect_to old_url if browser.ie6? || browser.ie7? ||browser.ie8? 
      end
    end
  end


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def add_how_many_words_left(story)
    count ||= story.story_lines.map {|i| i.line}.join(' ').squish.strip.split(' ').count
    55-count
  end
  helper_method :add_how_many_words_left


  def until_55_words(story, line)
    count = 0
    count = add_how_many_words_left story unless story.nil?
    line_arr = line.squish.strip.split(' ')
    line_arr[0..55-count-1].join(' ')
  end

  def update_if_complete(story)
      limit = add_how_many_words_left story
      logger.debug "limit: #{limit}"

    if limit<1
      logger.debug "inside if limit"
      story.is_complete = true
      #story.assign_attributes({ :is_complete => true })
      story.update_attribute(:is_complete, true)
    end
  end



  
  def in_wizard
     cookies[:register_wizard]=='1'
  end
  helper_method :in_wizard

  def end_wizard
    cookies.delete :register_wizard
  end

  

end
