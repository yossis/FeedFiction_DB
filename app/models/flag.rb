class Flag < ActiveRecord::Base
  attr_accessible :flag_reason_id, :reason, :reporter_user_id, :story_id

  validates :flag_reason_id , presence: true
end
