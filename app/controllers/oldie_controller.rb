class OldieController < ApplicationController
	layout  false
	skip_before_filter :ie_disclaimer
	
  def show
  end
end
