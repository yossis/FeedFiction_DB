module ImportImagesHelper
	def aspect_ratio(width,height,new_width)
		#original height / original width x new width = new height
		new_height = (height.to_f/width.to_f*new_width).to_i
		ratio = { "new_height" => new_height, "new_width" => new_width }
	end
end
