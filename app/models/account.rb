class Account < ActiveRecord::Base
  attr_accessible :enable, :name, :password, :username
  validates :username, presence: true
  validates_uniqueness_of :username
  validates :password , presence: true

  def self.authorize(usr,pwd)
  	u = where(username: usr, password: pwd, enable: true).first
  end
end
