module ImagesHelper
	def image_thumb(image)
		# if image.image_thumb?
		# 	image.image_thumb_url(:thumb)
		# else
		# 	image.image_source
		# end
		image.image_source
	end
end
