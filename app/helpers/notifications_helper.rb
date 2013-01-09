module NotificationsHelper
	def link_to_story_with_owner(notify)
		link =  link_to notify.story.story_title, story_url(notify.story) 
		link += notify.story.user_id==current_user.id ? ' that you started' : ' that you participated in'
		link.html_safe
		
	end
end
