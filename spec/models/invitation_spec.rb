# == Schema Information
#
# Table name: invitations
#
#  id              :integer          not null, primary key
#  sender_id       :integer
#  recipient_email :string(255)
#  token           :string(255)
#  sent_at         :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Invitation do
  pending "add some examples to (or delete) #{__FILE__}"
end
