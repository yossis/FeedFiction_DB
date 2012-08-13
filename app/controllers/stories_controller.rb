class StoriesController < ApplicationController
  
  def new
  end


  # GET /stories/1
  # GET /stories/1.json
  def show
    @story = Story.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @story }
    end
  end

   
  # POST /stories
  
  def create
    @story = Story.new(params[:story])
    @story.user_id = current_user.id
    if @story.save
        logger.debug 'New story saved - Creating story line'
        story_line = StoryLine.new()
        story_line.order_id = 0 if story_line.order_id.nil?
        story_line.order_id += 1
        story_line.story_id = @story.id
        story_line.user_id = current_user.id
        story_line.line = params[:line]
        if @story.story_lines<<story_line
          logger.debug 'Create a story line - yay! redirecting to general feed'
          redirect_to :controller => 'static_pages' ,:action => 'index'
        else
          logger.debug 'Error by creating a story line'
          render :action => 'new'
        end
   
    else
     logger.debug 'Error by creating a story'
     render :action => 'new'
    end
  end

  
end
