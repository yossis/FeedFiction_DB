class Notification < ActiveRecord::Base
  attr_accessible :date_read, :notifed_user_id, :notification_type_id, :notifier_user_id, :object_id, :story_id
end
