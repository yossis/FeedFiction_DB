# == Schema Information
#
# Table name: last_imports
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  image_type_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class LastImport < ActiveRecord::Base
  attr_accessible :image_type_id, :user_id, :updated_at

  def self.can_import_before_limit(type_id,uid)
  	limit = 2
  	last = where(image_type_id: type_id, user_id: uid).first
  	unless last.nil?
  	 	limit < ((Time.now - last.updated_at)/1.hour).round
  	else
  		true
  	end 
  end

 def self.update_time(type_id,uid)
 	where(image_type_id: type_id, user_id: uid).first_or_create.touch	
 end

end
