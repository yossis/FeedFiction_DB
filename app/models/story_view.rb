# == Schema Information
#
# Table name: story_views
#
#  id         :integer          not null, primary key
#  story_id   :integer
#  user_id    :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StoryView < ActiveRecord::Base
  attr_accessible :story_id, :user_id
end
