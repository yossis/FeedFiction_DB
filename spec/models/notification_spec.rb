# == Schema Information
#
# Table name: notifications
#
#  id                   :integer          not null, primary key
#  notifier_user_id     :integer
#  notified_user_id     :integer
#  notification_type_id :integer
#  story_id             :integer
#  item_id              :string(255)
#  date_read            :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'spec_helper'

describe Notification do
  pending "add some examples to (or delete) #{__FILE__}"
end
