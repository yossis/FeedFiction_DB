module StoriesHelper

	def story_title(story)
		lines = story.story_lines
		lines.map {|i| i.line}.join(' ').split(' ')[0..3].join(' ').capitalize
		
	end
	
end
