# == Schema Information
#
# Table name: flags
#
#  id               :integer          not null, primary key
#  story_id         :integer          not null
#  flag_reason_id   :integer
#  reason           :string(255)
#  reporter_user_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Flag do
  pending "add some examples to (or delete) #{__FILE__}"
end
