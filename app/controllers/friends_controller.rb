class FriendsController < ApplicationController

  def index
  	@users = current_user.people_to_follow.paginate(page: params[:page] , per_page: 100)
  end

end
