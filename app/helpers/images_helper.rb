module ImagesHelper
	def image_thumb(image)
		if image.image_processed?
			url = image.image_thumb_url(:thumb)
			image_tag(url, height: image.height, width: image.width, style: "height:#{image.height}px;width:#{image.width}")
			
		else
			image_tag(image.image_source, height: image.height, width: image.width , style: "height:#{image.height}px;width:#{image.width}")
		end
	end

	def image_thumb_or_source_url(image)
		if image.image_processed?
			image.image_thumb_url(:thumb)
		else
			image.image_source
		end
	end
end
