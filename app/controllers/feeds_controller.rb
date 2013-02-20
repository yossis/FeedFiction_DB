class FeedsController < ApplicationController
  before_filter :end_wizard,:init_vars

  def general_feed
    @stories = Story.includes([{story_lines: :user}, :image, :user, :likes , {comments: :user}]).where(status: 1).paginate(page: params[:page]).order('updated_at DESC')
    #Category.includes(:posts => [{:comments => :guest}, :tags])
    @everything_active = 'class=active'
    render 'index'
  end
  
  def index
    if current_user
      @feed_name = 'My Feed'
      @feed_logo_color = 'myfeed-logo'
      @stories = Story.includes([{:story_lines => :user}, :image, :user, :likes]).from_users_followed_by(current_user).paginate(page: params[:page])
      @my_feed_active = 'class=active'
    else
      general_feed
    end
    
  end

  private

    def init_vars
     @feed_name = 'All Stories'
     @feed_logo_color = 'everything-logo'
     @donot_show_disclaimer = true
      if session[:fire_insta_box]==1
        session.delete :fire_insta_box
        @connect_instagram=1
      end
      if current_user
        @friends = current_user.people_to_follow.limit(3)
      end
    end


end
