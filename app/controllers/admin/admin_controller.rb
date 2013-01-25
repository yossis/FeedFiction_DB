class Admin::AdminController < ApplicationController
	http_basic_authenticate_with :name => "yosYos", :password => "yosYos"
	protect_from_forgery
	layout "Admin/admin"

	def index
		
	end
end
