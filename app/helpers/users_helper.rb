module UsersHelper

	def basic_avatar(user)
		link_to image_tag(user.avatar,:class => 'border-image-small') ,user, :title => user.name
	end

	def user_link(user, options={})
		link_to(user.name , user , options.merge(:title => user.name))
	end

	def normal_avatar(user, options={})
		link_to image_tag(user.facebook.get_picture('me',:type => 'large')) ,user, options.merge(:title => user.name)
	end
end