class Admin::UsersController < Admin::ResourceController
	def index
		@users = User.paginate(page: params[:page]).order('id DESC')
		
	end
end
