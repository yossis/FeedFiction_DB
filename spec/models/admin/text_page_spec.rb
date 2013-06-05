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

require 'spec_helper'

describe Admin::TextPage do
  pending "add some examples to (or delete) #{__FILE__}"
end
