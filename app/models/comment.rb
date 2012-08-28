class Comment < ActiveRecord::Base
  attr_accessible :comment, :story_id, :user_id
  belongs_to :user
  belongs_to :stories

  validates :comment, presence: true
end
