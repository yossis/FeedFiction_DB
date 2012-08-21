class Story < ActiveRecord::Base
  attr_accessible :category_id, :image_url, :inappropreate, :is_compleate, :quality, :story_source_id, :user_id
  has_many :story_lines, :order => 'order_id ASC'
  has_many :likes , dependent: :destroy
  has_many :users , through: :likes, source: :users
  belongs_to :user
  belongs_to :category

  validates :image_url, presence: true 

  def like?(user_id)
  	likes.find_by_user_id(user_id)  		
  end

  def like!(user_id)
    likes.create!(user_id: user_id)
  end

  def unlike!(user_id)
    likes.find_by_user_id(user_id).destroy
  end
end
