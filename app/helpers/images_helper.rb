module ImagesHelper
	def image_thumb(image)
		# if image.image_thumb?
		# 	image.image_thumb_url(:thumb)
		# else
		# 	image.image_source
		# end
		image.image_source
	end

	def avatar_rounded(user)
		# img = '<div class="round-avatar"><div></div>'+ link_to(image_tag(user.avatar) ,user, title: user.name)
		# img +='</div>'
		img = '<div class="round-avatar">'+ link_to(image_tag(user.avatar, class: 'img-circle') ,user, title: user.name)
		img +='</div>'
		img.html_safe
	end

	def avatar_rounded_large(user)
		# img = '<div class="round-avatar"><div></div>'+ link_to(image_tag(user.avatar) ,user, title: user.name)
		# img +='</div>'
		img = '<div class="round-avatar-large">'+ link_to(image_tag(user.avatar, size: "90x90", class: 'img-circle' ) ,user, title: user.name)
		img +='</div>'
		img.html_safe
	end
end
