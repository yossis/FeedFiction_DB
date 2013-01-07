# == Schema Information
#
# Table name: notifications
#
#  id                   :integer          not null, primary key
#  notifier_user_id     :integer
#  notified_user_id     :integer
#  notification_type_id :integer
#  story_id             :integer
#  item_id              :string(255)
#  date_read            :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Notification < ActiveRecord::Base
  attr_accessible :date_read, :notified_user_id, :notification_type_id, :notifier_user_id, :item_id, :story_id
  
  belongs_to :notifier, class_name: "User" ,foreign_key: 'notifier_user_id'
  belongs_to :notified, class_name: "User" ,foreign_key: 'notified_user_id'
  belongs_to :notification_type
  belongs_to :story

def Notification.notify(item, user)
	item_name = nil
	logger.info("Notification::::::::: #{item.class}")
	case item.class.to_s
		when 'StoryLine'
			  notify_story(item,user)
		when 'Comment'
			  comment_on_story(item,user)
		when 'Like'
			  like_story(item,user)
	end

end

def is_new?
	date_read.nil?
end

def update_view
	update_attributes(date_read: Time.now)
end


private
	def Notification.notify_story(item , current_user)
		notification_type = NotificationType.find_by_name('Story')
		users = item.story.writers.uniq
		users.delete_if {|user| user==current_user} 
		users.each do |u|
    		self.create(:notified_user_id => u.id, :notification_type_id => notification_type.id, :notifier_user_id => current_user.id , :item_id => "sl-#{item.id}", :story_id => item.story_id)
    		UserMailer.delay.continue_story(item.story , u, current_user)
    	end
		
	end

	def Notification.comment_on_story(item , current_user)
		notification_type = NotificationType.find_by_name('Comment')
		users = (item.story.writers+item.story.commenters).uniq
		users.delete_if {|user| user==current_user} 
		users.each do |u|
    		self.create(:notified_user_id => u.id, :notification_type_id => notification_type.id, :notifier_user_id => current_user.id , :item_id => "co-#{item.id}", :story_id => item.story_id)
    		UserMailer.delay.comment_on_story(item , u, current_user)
    	end
		
	end

	def Notification.like_story(item , current_user)

		notification_type = NotificationType.find_by_name('Like')
		users = item.story.writers.uniq
		users.delete_if {|user| user==current_user} 
		
		users.each do |u|
    		self.create(:notified_user_id => u.id, :notification_type_id => notification_type.id, :notifier_user_id => current_user.id , :item_id => "st-#{item.story_id}", :story_id => item.story_id)
    		logger.info 'before create like smtp'
    		UserMailer.delay.like_story(item.story , u, current_user)
    	end
		
	end
  
end
