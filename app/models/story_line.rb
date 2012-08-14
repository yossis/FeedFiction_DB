class StoryLine < ActiveRecord::Base
  attr_accessible :is_flagged, :line, :order_id, :story_id, :user_id
  belongs_to :story
  belongs_to :user 
  
  validates :line, presence: true
end
