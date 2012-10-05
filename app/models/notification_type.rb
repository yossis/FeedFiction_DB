# == Schema Information
#
# Table name: notification_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class NotificationType < ActiveRecord::Base
  attr_accessible :name
  has_one :notification
end
