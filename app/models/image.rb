# == Schema Information
#
# Table name: images
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  source_object_id :string(255)
#  image_source       :string(255)
#  source_width     :integer
#  source_height    :integer
#  image_type_id    :integer
#  url              :string(255)
#  width            :integer
#  height           :integer
#  image_processed  :boolean          default(FALSE)
#  in_cdn           :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  album_type_id    :integer
#

class Image < ActiveRecord::Base
  attr_accessible :height, :source_object_id, :image_type_id, :image_processed, :in_cdn, :source_height, :image_source, :source_width, :image_thumb, :user_id, :width ,:album_type_id 
  has_one :story
  
  mount_uploader :image_thumb, ImageUploader

  #after_save :enqueue_image

  def create_by_upload
      #self.url = "#{ENV["AWS_S3_URL"]}/uploads/thumb_"+self.image_source.identifier
      #save
  end

  def saving
    geometry = self.url.geometry
    if (! geometry.nil?)
      self.source_width = geometry[0]
      self.source_height = geometry[1]
    end

    geometry = self.image_thumb.thumb.geometry
    if (! geometry.nil?)
      self.width = geometry[0]
      self.height = geometry[1]
    end
  end

  def enqueue_image
    ImageWorker.perform_async(id, key) if key.present?
    #ImageWorker.perform(id, key) if key.present?
  end

  class ImageWorker
    include Sidekiq::Worker
    
    def perform(id, key)
     image = Image.find(id)
     image.key = key
     #image.remote_image_thumb_url = "#{ENV["AWS_S3_URL"]}"+key
     image.remote_image_thumb_url = image.image_thumb.direct_fog_url(with_path: true)
     image.save!
     image.update_column(:image_processed, true)
    end
  end
  

  class << Image

    def get_images(user ,type_id)
      if LastImport.was_before_limit(type_id,user.id)
        case type_id
          when ImageType.instagram_id 
            images = import_images_instagram(user)
          when ImageType.facebook_id 
            images = import_images_facebook(user)
        end
        update_or_create(images,type_id,user)
      end
      Image.where(image_type_id: type_id, user_id: user.id)
    end

    # def instagram_images(user)
    #   type_id = ImageType.instagram_id
    #   if LastImport.was_before_limit(type_id,user.id)
    #     images = import_images_facebook(user)
        
    #     update_or_create(images,type_id,user.id)
    #   end
    #   Image.where(image_type_id: type_id, user_id: user.id)
    # end

    private

      def import_images_facebook(user)
        fql_query = 'SELECT object_id,src_big,src_big_height,src_big_width FROM photo WHERE aid IN (SELECT aid FROM album WHERE owner=me()) ORDER BY object_id DESC'
        images = user.facebook.fql_query(fql_query)
      end

      def import_images_instagram(user)
        access_token = user.get_token_provider('Instagram')
        client = Instagram.client(access_token: access_token)
        images = client.user_recent_media
      end

      def update_or_create(images, type_id,user)
        images.each do |image|
          item = Image.where(:image_type_id => type_id,:source_object_id => image['object_id'].to_s )
          if item.empty? 
            case type_id
              when ImageType.instagram_id
                store_instagram_image(image,type_id, user)
              when ImageType.facebook_id
                store_facebook_image(image,type_id, user)
            end
          end
        end
        LastImport.update_time(type_id, user.id)
      end

      def store_facebook_image(image,type_id, user)
        ratio = aspect_ratio(image['src_big_width'], image['src_big_height'], 365)
            i = Image.new(user_id: user.id, source_object_id: image['object_id'].to_s,
                  image_type_id: type_id ,
                  source_height: image['src_big_height'] ,
                  image_source: image['src_big'] ,
                  source_width: image['src_big_width'] ,
                  url: image['src_big'] ,
                  width: ratio['new_width'] ,
                  height: ratio['new_height'])
            i.save!
      end

      def store_instagram_image(media,type_id, user)
        ratio = aspect_ratio(media.images.standard_resolution.width, media.images.standard_resolution.height, 365)
        i = Image.new(user_id: user.id, source_object_id: media.images.id,
                  image_type_id: type_id ,
                  source_height: media.images.standard_resolution.height ,
                  image_source: media.images.standard_resolution.url ,
                  source_width: media.images.standard_resolution.width ,
                  width: ratio['new_width'] ,
                  height: ratio['new_height'])
            i.save!
        
      end

      def aspect_ratio(width,height,new_width)
       #original height / original width x new width = new height
       new_height = (height.to_f/width.to_f*new_width).to_i
       ratio = { "new_height" => new_height, "new_width" => new_width }
      end
  end

end
