class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :stories

  validates :name, presence: true
end
