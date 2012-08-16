class Story < ActiveRecord::Base
  attr_accessible :category_id, :image_url, :inappropreate, :is_compleate, :quality, :story_source_id, :user_id
  has_many :story_lines, :order => 'order_id ASC'
  belongs_to :user
  belongs_to :category

  validates :image_url, presence: true 


end
