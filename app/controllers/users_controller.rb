class UsersController < ApplicationController
  before_filter :set_common_vars

  def show
    @active_stories = 'class=active'
  	@story_line = StoryLine.new()
  	@new_comment = Comment.new
  	@stories = @user.participate_stories.paginate(page: params[:page]).order('created_at DESC')
  end

  def following
    @active_following = 'class=active'
    @title = 'Following'
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @active_followers = 'class=active'
    @title = 'Followers'
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def likes
    @title = 'Likes'
    @active_likes = 'class=active'
    @stories = @user.liked_stories.paginate(page: params[:page]) 
    @comment = Comment.new
    render 'show_likes'
  end

  def set_common_vars
    @user = User.find(params[:id])
    @is_user_page = true
    
  end
end
