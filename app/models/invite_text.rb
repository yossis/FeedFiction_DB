class InviteText < ActiveRecord::Base
  attr_accessible :content, :story_type, :title

  def self.rand_continue
  	self.where(story_type: 1).offset(rand(InviteText.count(conditions: ["story_type = ?", 1]))).first
  end 

  def self.rand_complete
  	self.where(story_type: 2).offset(rand(InviteText.count(conditions: ["story_type = ?", 2]))).first
  end  
end
