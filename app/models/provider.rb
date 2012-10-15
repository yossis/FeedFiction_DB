class Provider < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider_name, :uid, :user_id

  belongs_to :user

  def self.set_provider(provider_name, auth, user_id)
  	where(provider_name: provider_name , user_id: user_id).first_or_initialize.tap do |provider|
  		provider.oauth_token = auth.access_token
  		provider.name = auth.user.username
  		provider.uid = auth.user.id
  		provider.provider_name = provider_name
  		provider.user_id = user_id
  		provider.save!
	    provider
  	end
  end

end

