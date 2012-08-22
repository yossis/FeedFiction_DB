module UsersHelper

	def basic_avatar(user)
		link_to image_tag(user.avatar,:class => 'border-image-small') ,'#', :title => user.name
	end

	def user_link(user, options={})
		link_to(user.name , '#' , options.merge(:title => user.name))
	end
end