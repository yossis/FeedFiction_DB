# == Schema Information
#
# Table name: images
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  source_object_id :string(255)
#  source_url       :string(255)
#  source_width     :integer
#  source_height    :integer
#  image_type_id    :integer
#  url              :string(255)
#  width            :integer
#  height           :integer
#  is_proceed       :boolean          default(FALSE)
#  in_cdn           :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  album_type_id    :integer
#

require 'spec_helper'

describe Image do
  pending "add some examples to (or delete) #{__FILE__}"
end
