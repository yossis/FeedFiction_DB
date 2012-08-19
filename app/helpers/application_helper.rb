module ApplicationHelper
	# Returns the full title on a per-page basis.
	  def full_title(page_title)
	    base_title = "FeedFiction | Transform your photos to stories"
	    if page_title.empty?
	      base_title
	    else
	      "#{page_title} - FeedFiction.com"
	    end
	  end
end
