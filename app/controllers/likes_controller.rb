class LikesController < ApplicationController
  
  def show
    @story =  Story.find(params[:id])
    render partial: 'likes/like_list'
  end


  def create
  	@story =  Story.find(params[:like][:story_id])
  	@story.like!(current_user.id)
    Notification.notify(@story.likes.last ,current_user)
  	respond_to do |format|
      format.js
    end
  end

  def destroy
  	@story =  Like.find(params[:id]).story
  	@story.unlike!(current_user.id)
  	render template: 'likes/create.js'
  end
end
