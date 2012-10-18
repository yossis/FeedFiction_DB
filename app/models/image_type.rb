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
  has_many :images

  validates :name, presence: true

  def self.facebook_id
  	type ||= where(name: 'Facebook' ).first.id
  end

  def self.instagram_id
  	type ||= where(name: 'Instagram' ).first.id
  end

  def self.upload_id
  	type ||= where(name: 'Upload' ).first.id
  end
end
