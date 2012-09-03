class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@story_line = StoryLine.new()
  	@new_comment = Comment.new
  	@stories = @user.stories.paginate(page: params[:page], per_page: 2)
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def likes
    @title = 'Likes'
    @user = User.find(params[:id])
    @stories = @user.liked_stories.paginate(page: params[:page]) 
    @comment = Comment.new
    render 'show_likes'
  end
end
