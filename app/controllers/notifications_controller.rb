class NotificationsController < ApplicationController
	layout 'static_pages'
  def show
  	@feed_name = 'Notifications'
    @feed_logo_color = 'notifications-logo'
    @static_page_full_name = @feed_name
    @static_page_story_image = 'notifications-story-photo'
    @is_notifications = true
  	@notifications = current_user.notifications.paginate(page: params[:page]).order('created_at DESC')
  end

end
