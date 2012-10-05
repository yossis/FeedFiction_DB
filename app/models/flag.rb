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

class Flag < ActiveRecord::Base
  attr_accessible :flag_reason_id, :reason, :reporter_user_id, :story_id
  belongs_to :story

  validates :flag_reason_id , presence: true
end
