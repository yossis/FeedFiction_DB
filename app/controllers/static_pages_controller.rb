class StaticPagesController < ApplicationController
  layout 'static_pages'
  before_filter :init_vars

  def terms
    @active_terms = 'active'
  end

  def privacy
    @feed_name = 'Privacy'
    @feed_logo_color = 'privacy-logo'
    @static_page_full_name = 'Privacy Policy'
    @static_page_story_image = 'privacy-story-photo'
    @active_privacy = 'active'
  end

  def about
    @feed_name = 'About us'
    @feed_logo_color = 'about-logo'
    @static_page_full_name = @feed_name
    @static_page_story_image = 'about-story-photo'
    @active_about = 'active'
  end

  
  def help
  	@feed_name = 'FAQ'
    @feed_logo_color = 'help-logo'
    @static_page_full_name = @feed_name
    @static_page_story_image = 'help-story-photo'
    @active_help = 'active'
  end

  private

  def init_vars
     @feed_name = 'Terms'
     @feed_logo_color = 'terms-logo'
     @static_page_full_name = 'Terms of Use'
     @static_page_story_image = 'terms-story-photo'
     
    end
end
