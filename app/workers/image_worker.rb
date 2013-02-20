class ImageWorker
  include Sidekiq::Worker
  
  def perform(id, key)
   image = Image.find(id)
   image.key = key
   #image.remote_image_thumb_url = "#{ENV["AWS_S3_URL"]}"+key
   image.remote_image_thumb_url = image.image_source
   image.save!

   image.update_column(:image_processed, true)
  end
end