# == Schema Information
#
# Table name: story_lines
#
#  id         :integer          not null, primary key
#  story_id   :integer
#  user_id    :integer
#  order_id   :integer          default(1)
#  line       :text
#  is_flagged :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StoryLine < ActiveRecord::Base
  attr_accessible :is_flagged, :line, :order_id, :story_id, :user_id
  belongs_to :story
  belongs_to :user 
  
  validates :line, presence: true
  validates :user_id, presence: true

  def self.last_by_order(story_id)
    where(:story_id => story_id).last
  end
end
