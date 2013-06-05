# == Schema Information
#
# Table name: invite_texts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :string(255)
#  story_type :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe InviteText do
  pending "add some examples to (or delete) #{__FILE__}"
end
