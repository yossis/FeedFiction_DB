class NotificationType < ActiveRecord::Base
  attr_accessible :name
  has_one :notification
end
