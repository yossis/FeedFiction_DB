class Story < ActiveRecord::Base
  attr_accessible :category_id, :image_id, :inappropriate, :is_complete, :quality, :story_source_id, :user_id
  has_many :story_lines, :order => 'order_id ASC'
  has_many :likes , dependent: :destroy
  has_many :users , through: :likes, source: :users
  has_many :comments
  has_many :writers, through: :story_lines, source: :user
  belongs_to :image
  belongs_to :user
  belongs_to :category

  validates :image_id, presence: true 

  self.per_page = 10

  def story_title
    lines = self.story_lines.first
    lines.line.split(' ')[0..3].join(' ').capitalize
  end

  def description
    lines = self.story_lines
    lines.map {|i| i.line}.join(' ').split(' ')[0..30].join(' ').capitalize
  end

  def story_image
    self.image.url
  end

  def author
    self.user.name
  end

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
