class Account < ActiveRecord::Base
  attr_accessible :enable, :name, :password, :username

  def self.authorize(usr,pwd)
  	u = where(username: usr, password: pwd, enable: true).first
  end
end
