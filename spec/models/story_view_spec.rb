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

require 'spec_helper'

describe StoryView do
  pending "add some examples to (or delete) #{__FILE__}"
end
