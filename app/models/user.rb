class User < ActiveRecord::Base
  attr_accessible :avatar, :email, :gender, :name, :nick_name, :oauth_expires_at, :oauth_token, :provider, :uid, :login_count

  has_many :stories
  has_many :story_lines

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
end
