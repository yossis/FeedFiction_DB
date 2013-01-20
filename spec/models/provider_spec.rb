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

require 'spec_helper'

describe Provider do
  pending "add some examples to (or delete) #{__FILE__}"
end
