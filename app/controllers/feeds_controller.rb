class FeedsController < ApplicationController
  before_filter :end_wizard
  
  def index
  	 @stories = Story.paginate(page: params[:page]).order('updated_at DESC')
  	 @story_line = StoryLine.new
     @donot_show_disclaimer = true
  end


end
