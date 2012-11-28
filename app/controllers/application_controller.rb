class ApplicationController < ActionController::Base
  protect_from_forgery
  #http_basic_authenticate_with :name => "frodo", :password => "thering"
  before_filter :authenticate

  private

  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
  helper_method :mobile_device?
  

  def authenticate
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |username, password|
         u = Account.authorize(username,password)
         u.present?
      end 
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def add_how_many_words(lines)
    words = Array.new
    lines.each do |w|
      words.push w.line
    end
    55-words.join(' ').split(' ').count
  end
  helper_method :add_how_many_words

  def in_wizard
     cookies[:register_wizard]=='1'
  end
  helper_method :in_wizard

  def end_wizard
    cookies.delete :register_wizard
  end

  

end
