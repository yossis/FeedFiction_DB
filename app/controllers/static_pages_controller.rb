class StaticPagesController < ApplicationController
  def terms
  end

  def privacy
  end

  def about
  end

  def index
  	 @stories = Story.paginate(page: params[:page], per_page: 2)
  	 @story_line = StoryLine.new()
     @new_comment = Comment.new
  end
end
