class NotificationsController < ApplicationController
  def show
  	@notifications = current_user.notifications.paginate(page: params[:page]).order('created_at DESC')
  end

end
