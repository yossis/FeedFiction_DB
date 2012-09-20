class NotificationsController < ApplicationController
  def show
  	@notifications = Notification.find_all_by_notified_user_id(current_user.id)
  end

end
