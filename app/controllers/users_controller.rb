class UsersController < ApplicationController
  before_filter :set_common_vars,:find_page


  def show
    @active_stories = 'class=active'
  	@story_line = StoryLine.new()
  	@new_comment = Comment.new
  	@stories = @user.participate_stories.where("status=1 #{sort_feed}").paginate(page: params[:page]).order('created_at DESC')
    if @user==current_user
      @empty_disclaimer = 'You have no stories yet'
    else
      @empty_disclaimer = "#{@user.name} doesn't have stories yet"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js { render 'feeds/index' }
    end
  end

  # GET /users/1/edit
  def edit
    @user=current_user
  end

  def following
    @active_following = 'class=active'
    @title = 'Following'
    @users = @user.followed_users.paginate(page: params[:page])
    if @user==current_user
      @empty_disclaimer = 'You are not following yet'
    else
      @empty_disclaimer = "#{@user.name} isn't following yet"
    end
    render 'show_follow'
  end

  def followers
    @active_followers = 'class=active'
    @title = 'Followers'
    @users = @user.followers.paginate(page: params[:page])
    if @user==current_user
      @empty_disclaimer = 'You have no followers yet'
    else
      @empty_disclaimer = "#{@user.name} doesn't have followers yet"
    end
    render 'show_follow'
  end

  def likes
    @title = 'Likes'
    @active_likes = 'class=active'
    @stories = @user.liked_stories.paginate(page: params[:page]) 
    @comment = Comment.new
    if @user==current_user
      @empty_disclaimer = 'You have no like yet'
    else
      @empty_disclaimer = "#{@user.name} hasn't liked any stories yet"
    end
   
    respond_to do |format|
      format.html { render 'show_likes'}
      format.js { render 'feeds/index' }
    end
  end

  def set_common_vars
    @is_user_page = true
    
  end

  private


    def find_page
      @user ||= User.find_by_slug!(params[:id])
    end
end
