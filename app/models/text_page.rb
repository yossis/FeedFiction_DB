# == Schema Information
#
# Table name: text_pages
#
#  id         :integer          not null, primary key
#  page_type  :integer          default(0)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TextPage < ActiveRecord::Base
  attr_accessible :name, :page_type
end
