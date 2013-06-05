# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  provider               :string(255)
#  uid                    :string(255)
#  name                   :string(255)
#  nick_name              :string(255)
#  avatar                 :string(255)
#  email                  :string(255)
#  gender                 :string(255)
#  oauth_token            :string(255)
#  oauth_expires_at       :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  login_count            :integer          default(0)
#  big_avatar             :string(255)
#  cover                  :string(255)
#  invitation_id          :integer
#  invitation_limit       :integer          default(10)
#  admin                  :integer          default(0)
#  status                 :integer          default(1)
#  slug                   :string(255)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

require 'admin/faker'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :remember_me ,
  :avatar, :email, :gender, :name, :nick_name, :oauth_expires_at, :oauth_token, :provider, :uid, :login_count, :invitation_token, :invitation_limit, :admin ,:status, :slug

  has_many :authentications
  has_many :stories
  has_many :liked_stories, through: :likes , source: :story
  has_many :story_lines
  has_many :likes
  has_many :providers
  has_many :comments
  has_many :participate_stories, through: :story_lines , source: :story , uniq: true , :conditions => ['stories.status = ?',1]
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed , :conditions => ['relationships.status = ?',1]
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships
  has_many :notifications , foreign_key: 'notified_user_id'
  has_many :sent_invitations, class_name: 'Invitation', foreign_key: 'sender_id'
  has_one :faker ,class_name: 'Admin::Faker'
  belongs_to :invitation

  before_create :set_invitation_limit

  validates :slug, uniqueness: true, presence: true

  before_validation :generate_slug
  
  def password_required?
    super && provider.blank?
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize
  end

  def confirm!
    UserMailer.delay.welcome(self) if self.email.present?
    super
  end

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
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at) if auth.credentials.expires_at.present?
	    user.login_count +=1
      user.slug = user.name.parameterize
      #user.save!
      #user.authentications.build(provider:  auth.provider, uid: auth.uid, token: auth.credentials.token, token_secret: auth.credentials.secret)
      user
    end
	    #
	    #user
  end

  def self.get_guest(guest)
    where(guest.slice(:email)).first_or_create do |user|
      user.name = guest['name']
      user.nick_name = user.name.delete(' ')+'_'+('a'..'z').to_a.shuffle[0..7].join
      user.email = guest['email']
      user.slug = user.name.parameterize
      user.password = ('0'..'z').to_a.shuffle.first(8).join
      user
    end
    
  end

  def facebook
	  @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def is_facebooker?
    self.provider=="facebook"
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
    #relation = relationships.find_by_followed_id(other_user.id)
    relation = relationships.where(followed_id: other_user.id , status: 1)
    relation.first.status unless relation.empty?
  end

  def follow!(other_user)
    relation = relationships.find_by_followed_id(other_user.id)
    if relation.nil?
      r = relationships.create!(followed_id: other_user.id)
      #TODO: send notification
      Notification.notify(r , other_user)
    else
      relation.update_column('status', 1) if relation.status != 1
    end 
  end

  def unfollow!(other_user)
    r = relationships.find_by_followed_id(other_user.id)
    r.update_column('status', 0) 
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

  def people_to_follow
    followed = self.followed_users.size==0 ? 0 : self.followed_users
    follow = User.where('id NOT IN (?,?)', followed, self).order('random()')
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end    
  end

  private

  def set_invitation_limit
    self.invitation_limit = 10
  end

  # def avatar_large
  #   large_avatar ||= self.avatar.gsub('=square','=large')
  # end
  
end
