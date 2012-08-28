class StaticPagesController < ApplicationController
  def terms
  end

  def privacy
  end

  def about
  end

  def index
  	 @stories = Story.all.reverse
  	 @story_line = StoryLine.new()
     @new_comment = Comment.new
  end
end
