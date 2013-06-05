module UsersHelper

	def basic_avatar(user)
		link_to image_tag(user.avatar,:class => 'border-image-small') ,user, :title => user.name
	end

	def avatar_rounded(user)
		if user.nil? || user.avatar.nil?
			img = '<div class="round-avatar">'+ image_tag('fb_avatar.png', class: 'img-circle')
			img +='</div>'
			img.html_safe
		else
			# img = '<div class="round-avatar"><div></div>'+ link_to(image_tag(user.avatar) ,user, title: user.name)
			# img +='</div>'
			img = '<div class="round-avatar">'+ link_to(image_tag(user.avatar, class: 'img-circle') ,user, title: user.name)
			img +='</div>'
			img.html_safe
		end
	end

	def avatar_rounded_large(user)
		# img = '<div class="round-avatar"><div></div>'+ link_to(image_tag(user.avatar) ,user, title: user.name)
		# img +='</div>'
		avatar = user.avatar.nil? ? 'fb_avatar.png' : user.avatar
		img = '<div class="round-avatar-large">'+ link_to(image_tag(avatar, size: "90x90", class: 'img-circle' ) ,user, title: user.name)
		img +='</div>'
		img.html_safe
	end

	def avatar_rounded_medium(user)
		# img = '<div class="round-avatar"><div></div>'+ link_to(image_tag(user.avatar) ,user, title: user.name)
		# img +='</div>'
		img = '<div class="round-avatar-medium">'+ link_to(image_tag(user.avatar, size: "60x60", class: 'img-circle' ) ,user, title: user.name)
		img +='</div>'
		img.html_safe
	end

	def avatar_rounded_mini(user)
		# img = '<div class="round-avatar"><div></div>'+ link_to(image_tag(user.avatar) ,user, title: user.name)
		# img +='</div>'
		img = '<div class="round-avatar-mini">'+ link_to(image_tag(user.avatar, size: "30x30" , class: 'img-circle') ,user, title: user.name)
		img +='</div>'
		img.html_safe
	end
	def user_link(user, options={})
		link_to(user.name , user , options.merge(:title => user.name))
	end

	def normal_avatar(user, options={})
		link_to image_tag(user.avatar) ,user, options.merge(:title => user.name)
	end

	def current_user?(user)
		current_user==user
	end

	# def active_stories
	# 	'class="active"' if controller_name == "homepage" && action_name == "index" 
	# end
end