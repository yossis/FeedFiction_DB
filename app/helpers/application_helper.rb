module ApplicationHelper
	# Returns the full title on a per-page basis.
		def full_title(page_title)
			base_title = "Feedfiction :: Turn Photos into Beautiful Stories"
			if page_title.present?
				"#{page_title} - FeedFiction.com"
			else
				base_title
			end
		end

		def number_to_pixel(num ={})
			num ||= "365"
			"#{num}px"
		end

		def drop_down_categories
			@categories = Category.all
		render 'categories/categories_drop_down' 
		end

		def drop_cap(line)
	
			line = line.slice(0,1).capitalize + line.slice(1..-1)
			#line.gsub!(line[0],'<span class="dropcap">'+line[0]+'</span>')
			line.insert(1,'</span>').insert(0,'<span class="dropcap">')
			line.html_safe
			#'line[0]='+line[0]+', other='+line
		end

		
end
