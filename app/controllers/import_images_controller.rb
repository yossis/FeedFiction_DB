class ImportImagesController < ApplicationController
  def facebook
		 
		 #SELECT aid, owner, name FROM album WHERE owner='675499110'
		 #SELECT src,aid FROM photo WHERE aid IN (SELECT aid FROM album WHERE owner='675499110') 

		 
		 fql_query = 'SELECT src_big,src_big_height,src_big_width FROM photo WHERE aid IN (SELECT aid FROM album WHERE owner=me())'
		 @images = current_user.facebook.fql_query(fql_query)
		 #raise @images.to_yaml
		 @categories = Category.all
		 @story = Story.new
	end


  def instagram
  end

  def upload
  end
end
