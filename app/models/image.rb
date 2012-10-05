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
#  is_proceed       :boolean          default(FALSE)
#  in_cdn           :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  album_type_id    :integer
#

class Image < ActiveRecord::Base
  attr_accessible :height, :source_object_id, :image_type_id, :is_proceed, :in_cdn, :source_height, :image_source, :source_width, :url, :user_id, :width ,:album_type_id 
  has_one :story
  before_save :saving

  mount_uploader :image_source, ImageUploader

  def create_by_upload
      self.url = "#{ENV["AWS_S3_URL"]}/uploads/thumb_"+self.image_source.identifier
      save
  end

  def saving
    geometry = self.image_source.geometry
    if (! geometry.nil?)
      self.source_width = geometry[0]
      self.source_height = geometry[1]
    end

    geometry = self.image_source.thumb.geometry
    if (! geometry.nil?)
      self.width = geometry[0]
      self.height = geometry[1]
    end
  end  

  class << Image

    def facebook_images(user)
      type_id = ImageType.facebook_id
      if LastImport.was_before_limit(type_id,user.id)
        images = import_images_facebook(user)
        
        update_or_create(images,type_id,user.id)
      end
      Image.where(image_type_id: type_id, user_id: user.id)
    end

    private

    def import_images_facebook(user)
      fql_query = 'SELECT object_id,src_big,src_big_height,src_big_width FROM photo WHERE aid IN (SELECT aid FROM album WHERE owner=me()) ORDER BY object_id DESC'
      images = user.facebook.fql_query(fql_query)
    end

    def update_or_create(images, type_id,user_id)
      images.each do |image|
        foo = Image.where(:image_type_id => type_id,:source_object_id => image['object_id'].to_s )
        if foo.empty? 
          ratio = aspect_ratio(image['src_big_width'], image['src_big_height'], 365)
          i = Image.new(user_id: user_id, source_object_id: image['object_id'].to_s,
                image_type_id: type_id ,
                source_height: image['src_big_height'] ,
                image_source: image['src_big'] ,
                source_width: image['src_big_width'] ,
                url: image['src_big'] ,
                width: ratio['new_width'] ,
                height: ratio['new_height'])
          i.save!
        end
      end
      LastImport.update_time(type_id, user_id)
    end

   def aspect_ratio(width,height,new_width)
    #original height / original width x new width = new height
    new_height = (height.to_f/width.to_f*new_width).to_i
    ratio = { "new_height" => new_height, "new_width" => new_width }
   end
  end

end
