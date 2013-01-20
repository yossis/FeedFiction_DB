# == Schema Information
#
# Table name: providers
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  provider_name    :string(255)
#  uid              :string(255)
#  name             :string(255)
#  oauth_token      :string(255)
#  oauth_expires_at :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

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

