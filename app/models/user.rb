# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  provider         :string(255)
#  uid              :string(255)
#  name             :string(255)
#  nick_name        :string(255)
#  avatar           :string(255)
#  email            :string(255)
#  gender           :string(255)
#  oauth_token      :string(255)
#  oauth_expires_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  login_count      :integer          default(0)
#  big_avatar       :string(255)
#  cover            :string(255)
#  invitation_id    :integer
#  invitation_limit :integer          default(10)
#  admin            :integer          default(0)
#
require 'admin/faker'
class User < ActiveRecord::Base
  attr_accessible :avatar, :email, :gender, :name, :nick_name, :oauth_expires_at, :oauth_token, :provider, :uid, :login_count, :invitation_token, :invitation_limit, :admin ,:status

  has_many :stories
  has_many :liked_stories, through: :likes , source: :story
  has_many :story_lines
  has_many :likes
  has_many :providers
  has_many :comments
  has_many :participate_stories, through: :story_lines , source: :story ,uniq: true
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships
  has_many :notifications , foreign_key: 'notified_user_id'
  has_many :sent_invitations, class_name: 'Invitation', foreign_key: 'sender_id'
  has_one :faker ,class_name: 'Admin::Faker'
  belongs_to :invitation

  before_create :set_invitation_limit



  def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	  	#logger.debug { "user: #{user}" }
	    user.provider = auth.provider
	    #logger.debug { "user.provider: #{auth.provider}" }
	    user.uid = auth.uid
	    user.name = auth.info.name
	    user.nick_name = auth.info.nickname
	    user.avatar = auth.info.image
	    user.email = auth.info.email
	    user.gender = auth.extra.raw_info.gender
	    user.oauth_token = auth.credentials.token
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	    user.login_count +=1
	    user.save!
	    user
	 end
  end

  def facebook
	  @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def like?(story_id)
  	likes.find_by_story_id(story_id)  		
  end

  def like!(story_id)
    likes.create!(story_id: story_id)
  end

  def unlike!(story_id)
    likes.find_by_story_id(story_id).destroy
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def first_time?
    login_count==1
  end

  def has_notification?
    notifications.count>0
  end

  def new_notifications_count
    notifications.where(date_read: nil).count

  end

  def has_instagram?
    Provider.where(provider_name: 'Instagram', user_id: self.id).first
  end

  def get_token_provider(name)
    provider = Provider.where(user_id: self.id, provider_name: name).first
    provider.oauth_token unless provider.nil?
  end

  def fb_token_expired?
    self.oauth_expires_at < Time.now
  end

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end

  def admin?
    self.admin>0
  end

  private

  def set_invitation_limit
    self.invitation_limit = 10
  end

  # def avatar_large
  #   large_avatar ||= self.avatar.gsub('=square','=large')
  # end
  
end
