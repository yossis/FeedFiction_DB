class Story < ActiveRecord::Base
  attr_accessible :category_id, :image_id, :inappropriate, :is_complete, :quality, :story_source_id, :user_id
  has_many :story_lines, :order => 'order_id ASC'
  has_many :likes , dependent: :destroy
  has_many :users , through: :likes, source: :users
  has_many :comments
  belongs_to :image
  belongs_to :user
  belongs_to :category

  validates :image_id, presence: true 

  def like?(user_id)
  	likes.find_by_user_id(user_id)  		
  end

  def like!(user_id)
    likes.create!(user_id: user_id)
  end

  def unlike!(user_id)
    likes.find_by_user_id(user_id).destroy
  end

  def last_comments
    how_many = 3
    self.comments.order('id DESC').limit(how_many).reverse
  end
end
