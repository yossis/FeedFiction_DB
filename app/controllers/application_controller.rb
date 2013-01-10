class ApplicationController < ActionController::Base
  protect_from_forgery
  #http_basic_authenticate_with :name => "frodo", :password => "thering"
  before_filter :authenticate 
  before_filter :ie_disclaimer 

  private

  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
  helper_method :mobile_device?
  

  def authenticate
    if Rails.env.production? 
      authenticate_or_request_with_http_basic do |username, password|
        username == "foo" && password == "bar"
      #    u = Account.authorize(username,password)
      #    u.present?
      end 
    end
  end


  def ie_disclaimer
    if Rails.env.development? 
      
      if params[:debug]=='true'
        session[:ie] = 1
        redirect_to root_url
      else
        redirect_to old_url if browser.ie6?
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
