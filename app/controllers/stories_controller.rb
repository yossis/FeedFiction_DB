class StoriesController < ApplicationController
  
  
  # GET /stories/1
  # GET /stories/1.json
  def show
    @story = Story.find(params[:id])
    @story_line = StoryLine.new
    @comments = @story.comments
    @new_comment = Comment.new
    @new_comment.story_id = params[:id]
    set_meta_tags_and_title
    

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
    #TODO:validation - how to do?
    story_line = StoryLine.new(:line => params[:line], :order_id =>1, user_id: current_user.id)
    story_line.build_story(params[:story].merge :user_id => current_user.id)
    story_line.save!

    if in_wizard
      redirect_to find_friends_wizard_url
    else
      redirect_to root_url
    end
  end

  
end
