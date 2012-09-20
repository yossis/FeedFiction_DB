class Notification < ActiveRecord::Base
  attr_accessible :date_read, :notifed_user_id, :notification_type_id, :notifier_user_id, :object_id, :story_id

def Notification.notify(story_line, user)
	case story_line.class.to_s
	when 'StoryLine'
		  notify_story story_line, user
	end
	
end


private
	def Notification.notify_story(story_line , current_user)
		notification_type = NotificationType.find_by_name('Story')
		users = story_line.story.writers.uniq
		users.delete_if {|item| item==current_user} 
		users.each do |u|
    		self.create(:notifed_user_id => u.id, :notification_type_id => notification_type.id, :notifier_user_id => current_user.id , :object_id => "sl-#{story_line.id}", :story_id => story_line.story_id)
    		UserMailer.continue_story(@story_line.story , u, current_user).deliver
    	end
		
	end
  
end
