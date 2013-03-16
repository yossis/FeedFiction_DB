class Admin::StoriesController < Admin::ResourceController
	
	def index
		@stories = Story.includes([:story_lines, :image]).paginate(page: params[:page]).order('updated_at DESC')
	end

	def destroy
		@story = Story.find(params[:id])
		@story.status = 0
		@story.save!
		flash[:notice] = "The story #{@story.id} removed"
    redirect_to admin_stories_url
  end

  
end
