class StaticPagesController < ApplicationController
  def terms
  end

  def privacy
  end

  def about
  end

  def index
  	 @stories = Story.all
  	 @story_line = StoryLine.new()
  end
end
