module StoriesHelper
	def started_by(story)
		started_by = "Started #{time_ago_in_words story.created_at} Ago By:" +link_to(story.user.name , story.user)
        if (story.image.image_type.name=="Upload")
        	started_by += ' photo uploaded personally'
        else
			started_by += " photo from #{story.image.image_type.name}"
		end
		started_by.html_safe

	end

	def fb_write_activity(word, story_url)
		if params[:facebook]
      # key = @story.is_complete ? "complete" : "continue"
      FacebookWorker.perform_async(current_user.id , word, story_url)
    end
	end

end
