# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :integer          default(1)
#

require 'spec_helper'

describe Relationship do
  pending "add some examples to (or delete) #{__FILE__}"
end
