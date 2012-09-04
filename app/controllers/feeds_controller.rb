class FeedsController < ApplicationController
  def index
  	 @stories = Story.paginate(page: params[:page]).order('updated_at DESC')
  	 @story_line = StoryLine.new()
     @new_comment = Comment.new
  end
end
