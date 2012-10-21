class ImagesController < ApplicationController

  before_filter :check_user , :set_upload


  

  def facebook
   reconnect_with_facebook
 	 #SELECT aid, owner, name FROM album WHERE owner='675499110'
	 #SELECT src,aid FROM photo WHERE aid IN (SELECT aid FROM album WHERE owner='675499110') 

	 #fql_query = 'SELECT src_big,src_big_height,src_big_width FROM photo WHERE aid IN (SELECT aid FROM album WHERE owner=me())'
	 #@images = current_user.facebook.fql_query(fql_query)
	 #raise @images.to_yaml
	 @images = Image.get_images(current_user, ImageType.facebook_id)
	 
  end


  def instagram
    if (current_user.has_instagram?)
      @images = Image.get_images(current_user, ImageType.instagram_id)
      
    else
      redirect_to :controller => 'sessions', :action => 'connect_instagram' #if !session[:access_token] 
    end

  end

  def upload
    @image = Image.find(params[:id]) if params[:id].present?
    @image_type = ImageType.upload_id
    if @image.nil?
  	   @image = Image.new
    end
  end

  def show
    @image = Image.find(params[:id]) if params[:id].present?
    if @image.nil?
      @image = Image.new
    end

  end

  def new

    @image = Image.new(key:params[:key])
    #@image = Image.new(params[:image])
    @image.user_id = current_user.id
    @image.save
    debugger
    @image.enqueue_image
    
    render :upload_images
  end
	
  def create
    #get the url from the callbcack
    #e.g: image[image_source] = https://<BUCKET>.s3.amazonaws.com/uploads/myimage.png
    @image = Image.new
    @image.image_source = params[:key]
    @image.image_type_id = ImageType.upload_id
    @image.key =params[:key].sub("#{ENV['AWS_S3_URL']}/",'')
    @image.user_id = current_user.id
    @image.save
    @image.enqueue_image
    # render 'upload'
  end


  def set_upload
    @uploader = Image.new.image_thumb
    @uploader.success_action_redirect = new_image_url
  end

  def check_user
    unless current_user
      redirect_to root_url
    end
  end

  private
    def reconnect_with_facebook
    if current_user && current_user.fb_token_expired?

      # re-request a token from facebook. Assume that we got a new token so
      # update it anyhow...
      session[:return_to] = request.env["REQUEST_URI"] unless request.env["REQUEST_URI"] == facebook_request_path
      redirect_to(with_canvas(facebook_request_path)) and return false
    end
  end


end
