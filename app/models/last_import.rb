class LastImport < ActiveRecord::Base
  attr_accessible :image_type_id, :user_id, :updated_at

  def self.was_before_limit(type_id,uid)
  	limit = 6
  	last = where(image_type_id: type_id, user_id: uid).first
  	unless last.nil?
  	 	limit < ((Time.now - last.updated_at)/1.hour).round
  	else
  		true
  	end 
  end

 def self.UpdateTime(type_id,uid)
 	where(image_type_id: type_id, user_id: uid).first_or_create.touch	
 end

end
