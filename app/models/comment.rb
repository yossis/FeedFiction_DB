# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  story_id   :integer
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :comment, :story_id, :user_id
  belongs_to :user
  belongs_to :story

  validates :comment, presence: true
end
