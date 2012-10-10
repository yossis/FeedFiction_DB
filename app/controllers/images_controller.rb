class ImagesController < ApplicationController

  def facebook

 	 #SELECT aid, owner, name FROM album WHERE owner='675499110'
	 #SELECT src,aid FROM photo WHERE aid IN (SELECT aid FROM album WHERE owner='675499110') 

	 #fql_query = 'SELECT src_big,src_big_height,src_big_width FROM photo WHERE aid IN (SELECT aid FROM album WHERE owner=me())'
	 #@images = current_user.facebook.fql_query(fql_query)
	 #raise @images.to_yaml
	 @images = Image.facebook_images(current_user)
	 
  end


  def instagram
  end

  def upload
    @image = Image.find(params[:id]) if params[:id].present?
    
    if @image.nil?
  	   @image = Image.new
    end
    #@uploader = Image.new.image_source
    #@uploader.success_action_redirect = new_image_url

  end

  def show
    @image = Image.find(params[:id]) if params[:id].present?
    if @image.nil?
      @image = Image.new
    end

  end

  def new
    @image = Image.new(key:params[:key])
    @image.user_id = current_user.id
    @image.save
    #@uploader = Image.new.image_source
    #@uploader.success_action_redirect = new_image_url

  end
	
  def create
    #get the url from the callbcack
    #e.g: image[image_source] = https://<BUCKET>.s3.amazonaws.com/uploads/myimage.png
    @image = Image.new(params[:image])
    @image.user_id = current_user.id
    @image.save

    render 'upload'
  end


end
