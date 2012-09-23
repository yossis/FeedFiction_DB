class FlagsController < ApplicationController
  

  # GET /flags/new
  # GET /flags/new.json
  def new
    @flag = Flag.new
    @flag.story_id = params[:story_id]

    respond_to do |format|
      format.js
    end
    #respond_to do |format|
    #  format.html  { render :partial => 'new'}# new.html.erb
    #  format.json { render json: @flag }
    #end
  end

  
  # POST /flags
  # POST /flags.json
  def create
    @flag = Flag.new(params[:flag])
    @flag.reporter_user_id = current_user.id

    respond_to do |format|
      if @flag.save
        format.html { redirect_to @flag, notice: 'This story is flagged by you.' }
        format.json { render json: @flag, status: :created, location: @flag }
      else
        format.html { render action: "new" }
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end

  
end
