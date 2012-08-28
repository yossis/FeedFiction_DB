class Image < ActiveRecord::Base
  attr_accessible :height, :source_object_id, :image_type_id, :is_proceed, :is_used, :source_height, :source_url, :source_width, :url, :user_id, :width
  has_one :story

def self.facebook_images(user)
	type_id = ImageType.facebook_id
	if (LastImport.was_before_limit(type_id,user.id))
		images = import_images_facebook(user)
		
		update_or_create(images,type_id,user.id)
	end
	Image.all
end

private

  def self.import_images_facebook(user)
  	fql_query = 'SELECT object_id,src_big,src_big_height,src_big_width FROM photo WHERE aid IN (SELECT aid FROM album WHERE owner=me()) ORDER BY object_id DESC'
	images = user.facebook.fql_query(fql_query)
  end

  def self.update_or_create(images, type_id,user_id)
   	images.each do |image|
  		if where(:image_type_id => type_id,:source_object_id => image['object_id'].to_s ).empty? 
  			ratio = aspect_ratio(image['src_big_width'], image['src_big_height'], 365)
  			i = Image.new(user_id: user_id, source_object_id: image['object_id'].to_s,
  						image_type_id: type_id ,
  						source_height: image['src_big_height'] ,
  						source_url: image['src_big'] ,
  						source_width: image['src_big_width'] ,
  						url: image['src_big'] ,
  						width: ratio['new_width'] ,
  						height: ratio['new_height'])
	  		i.save!
  		end
  	end
  	LastImport.UpdateTime(type_id, user_id)
  end

   def self.aspect_ratio(width,height,new_width)
		#original height / original width x new width = new height
		new_height = (height.to_f/width.to_f*new_width).to_i
		ratio = { "new_height" => new_height, "new_width" => new_width }
   end
end
