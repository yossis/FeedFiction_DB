# == Schema Information
#
# Table name: flag_reasons
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FlagReason < ActiveRecord::Base
  attr_accessible :name
end
