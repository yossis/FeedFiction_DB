# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  username   :string(255)
#  password   :string(255)
#  enable     :boolean          default(TRUE)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account < ActiveRecord::Base
  attr_accessible :enable, :name, :password, :username
  validates :username, presence: true
  validates_uniqueness_of :username
  validates :password , presence: true

  def self.authorize(usr,pwd)
  	u = where(username: usr, password: pwd, enable: true).first
  end
end
