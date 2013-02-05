class Admin::StoriesController < Admin::ResourceController
	def index
		@stories = Story.paginate(page: params[:page]).order('updated_at DESC')
		
	end
end
