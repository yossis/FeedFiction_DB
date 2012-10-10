# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  #include CarrierWaveDirect::Uploader
  
  include CarrierWave::RMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :fog

  include CarrierWave::MimeTypes
  process :set_content_type

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  process :get_geometry

  def geometry
      @geometry
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_limit => [365, nil]
    process :get_geometry
  end



  def get_geometry
    if (@file)
      img = ::Magick::Image::read(@file.file).first
      @geometry = [ img.columns, img.rows ]
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(jpg jpeg gif png)
  end

  
end
