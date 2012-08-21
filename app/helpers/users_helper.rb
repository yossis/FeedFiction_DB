module UsersHelper

	def basic_avatar(user)
		link = link_to image_tag(user.avatar,:class => 'border-image-small') ,'#', :title => user.name
	end
end