class StoryLinesController < ApplicationController
  # GET /story_lines
  # GET /story_lines.json
  def index
    @story_lines = StoryLine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @story_lines }
    end
  end

  # GET /story_lines/1
  # GET /story_lines/1.json
  def show
    @story_line = StoryLine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @story_line }
    end
  end

  # GET /story_lines/new
  # GET /story_lines/new.json
  def new
    @story_line = StoryLine.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @story_line }
    end
  end

  # GET /story_lines/1/edit
  def edit
    @story_line = StoryLine.find(params[:id])
  end

  # POST /story_lines
  # POST /story_lines.json
  def create
    #raise params[:story_line].to_yaml

    @story_line = StoryLine.new(params[:story_line])
    @story_line.user_id = current_user.id
    last_line = StoryLine.last_by_order(params[:story_line][:story_id])

    #logger.debug "last_line: #{params[:story_line].attributes.inspect}"
    #logger.debug "Post should be valid: #{@post.valid?}"
    
    if (last_line.order_id==params[:story_line][:order_id].to_i)
        @story_line.order_id +=1
        @story_line.save!
        #notification
        Notification.notify(@story_line ,current_user)
        #UserMailer.continue_story(@story_line.story , current_user).deliver 
        
    else
      #duplicate story
    end
    @story = @story_line.story
    limit = add_how_many_words @story.story_lines
    logger.debug "limit: #{limit}"
    if limit<1
      logger.debug "inside if limit"
      @story.is_complete = true
      @story.save!
    end
    @story_line = StoryLine.new()
    respond_to do |format|
      format.js
    end
    #render json: @story_line, status: :created, location: @story_line
  end

  # PUT /story_lines/1
  # PUT /story_lines/1.json
  def update
    @story_line = StoryLine.find(params[:id])

    respond_to do |format|
      if @story_line.update_attributes(params[:story_line])
        format.html { redirect_to @story_line, notice: 'Story line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @story_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /story_lines/1
  # DELETE /story_lines/1.json
  def destroy
    @story_line = StoryLine.find(params[:id])
    @story_line.destroy

    respond_to do |format|
      format.html { redirect_to story_lines_url }
      format.json { head :no_content }
    end
  end
end
