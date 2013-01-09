class ContactsController < ApplicationController
  layout 'static_pages'
  before_filter :init_vars

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.valid?
      # TODO send message here
      Mailer.delay.contact_us(@contact)
      redirect_to root_url, notice: "Message sent! Thank you for contacting us."
    else
      render "new"
    end
  end


  private

    def init_vars
      @feed_name = 'Contact us'
      @feed_logo_color = 'contact-logo'
      @static_page_full_name = @feed_name
      @static_page_story_image = 'contact-story-photo'
      @active_contact = 'active'
 
    end
end
