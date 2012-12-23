module ImagesHelper
	def image_thumb(image)
		if image.image_processed?
			image.image_thumb_url(:thumb)
		else
			image.image_source
		end
	end
end
