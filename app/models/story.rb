# == Schema Information
#
# Table name: stories
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  image_id        :integer
#  is_complete     :boolean
#  inappropriate   :integer
#  quality         :integer
#  story_source_id :integer
#  category_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Story < ActiveRecord::Base
  attr_accessible :category_id, :image_id, :inappropriate, :is_complete, :quality, :story_source_id, :user_id, :last_line_updated_at
  has_many :story_lines#, :order => 'order_id ASC'
  accepts_nested_attributes_for :story_lines
  
  has_many :likes , dependent: :destroy
  has_many :users , through: :likes, source: :users
  has_many :comments
  has_many :commenters, through: :comments, source: :user
  has_many :writers, through: :story_lines, source: :user
  has_many :flags
  belongs_to :image
  belongs_to :user
  belongs_to :category

  after_save :play_with_image

  validates :image_id, presence: true 

  self.per_page = 10

  def play_with_image
    image.enqueue_image unless image.image_processed?
  end

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

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    stories_id = "SELECT DISTINCT story_id FROM story_lines WHERE (user_id IN (#{followed_user_ids}) OR user_id = :user_id)"
    #    StoryLine.select('story_id').where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
    #     user_id: user.id).uniq
    where("id IN (#{stories_id})",user_id: user.id).order('last_line_updated_at DESC')
  end
end
