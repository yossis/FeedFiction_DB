class ApplicationController < ActionController::Base
  protect_from_forgery

  private

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
end
