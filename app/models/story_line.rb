# == Schema Information
#
# Table name: story_lines
#
#  id         :integer          not null, primary key
#  story_id   :integer
#  user_id    :integer
#  order_id   :integer          default(1)
#  line       :text
#  is_flagged :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ip         :string(255)
#

class StoryLine < ActiveRecord::Base
  attr_accessible :is_flagged, :line, :order_id, :story_id, :user_id ,:ip
  belongs_to :story
  belongs_to :user 

  before_create :duplicate_story_if_needed
  after_create :send_notification
  after_save :update_story
  
  validates :line, presence: true
  validates :user_id, presence: true

  def self.last_by_order(story_id)
    StoryLine.where(:story_id => story_id).last
  end

  private

    def update_story
      self.story.touch(:last_line_updated_at)
    end

    def duplicate_story_if_needed
      if should_duplicate?
        duplicate_story
      # else
      #     self.order_id +=1
          #notification
          
          #UserMailer.continue_story(@story_line.story , current_user).deliver 
      end
    end

    def should_duplicate?
      
      last_line = StoryLine.last_by_order(self.story_id)
      return false if last_line.blank?

      last_line.order_id == order_id.to_i
    end

    def duplicate_story
     
      story.story_source_id = story.id
      story_attributes = clean_attributes story.attributes
      new_story = Story.create(story_attributes)
      duplicate_story_lines new_story
      self.story_id = new_story.id
    end

    def duplicate_story_lines(new_story)
      story.story_lines.each_with_index do |line, i|
        line_attributes = clean_attributes line.attributes
        line_attributes.delete "story_id"
        new_story.story_lines.create(line_attributes)

        break if self.order_id == line.order_id+1
      end
    end

    def clean_attributes(hash)
      hash.delete("id")
      hash.delete("created_at")
      hash.delete("updated_at")
      hash
    end

    def send_notification
      Notification.notify(self, user)
    end

end
