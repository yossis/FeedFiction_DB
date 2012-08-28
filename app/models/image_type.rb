class ImageType < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  def self.facebook_id
  	where(name: 'Facebook' ).first_or_create.id
  end
end
