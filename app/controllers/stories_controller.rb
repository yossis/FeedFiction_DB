class StoriesController < ApplicationController
  
  
  # GET /stories/1
  # GET /stories/1.json
  def show
    @story = Story.find(params[:id])
    @story_line = StoryLine.new
    @comments = @story.comments
    @new_comment = Comment.new
    @new_comment.story_id = params[:id]
    @in_story_page = true
    set_meta_tags_and_title
    

  end

  def testform
    
  end

  def set_meta_tags_and_title
    set_meta_tags :title => @story.story_title,
              :author => @story.author,
              :description => @story.description,
              :image => @story.image.image_thumb,
              :image_thumb => @story_url,
              :open_graph => { :title => @story.story_title, :url => @story_url, :type => 'text/html' ,
              :description => @story.description, :image => @story.image.image_thumb} 
  end

   
  # POST /stories
  
  def create
    # story = Story.new(params[:story])
    # story_line = story.story_lines.build
    # story.save!
    story_line = StoryLine.new(:line => until_55_words(nil,params[:story_line][:line]), :order_id =>1, user_id: current_user.id , ip: request.remote_ip)
    story_line.build_story(params[:story].merge :user_id => current_user.id)
    story_line.save!
    image = story_line.story.image
    image.enqueue_image if !image.image_processed && image.image_type.id != ImageType.upload_id

    update_if_complete story_line.story
    
    redirect_to root_url
    
  end

end
