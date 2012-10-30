class FeedsController < ApplicationController
  before_filter :end_wizard,:init_vars

  def general_feed
    @stories = Story.paginate(page: params[:page]).order('updated_at DESC')
    render 'index'
  end
  
  def index
    if current_user
      @stories = Story.from_users_followed_by(current_user).paginate(page: params[:page])
    else
      @stories = Story.paginate(page: params[:page]).order('updated_at DESC')
    end

  end

  private

    def init_vars
     @story_line = StoryLine.new
     @donot_show_disclaimer = true
    end


end
