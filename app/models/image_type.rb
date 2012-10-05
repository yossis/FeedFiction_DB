# == Schema Information
#
# Table name: image_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ImageType < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  def self.facebook_id
  	where(name: 'Facebook' ).first_or_create.id
  end
end
