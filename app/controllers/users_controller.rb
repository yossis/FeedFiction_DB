class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@story_line = StoryLine.new()
  end
end
