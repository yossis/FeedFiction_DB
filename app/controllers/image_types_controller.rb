class ImageTypesController < ApplicationController
  # GET /image_types
  # GET /image_types.json
  def index
    @image_types = ImageType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @image_types }
    end
  end

  # GET /image_types/1
  # GET /image_types/1.json
  def show
    @image_type = ImageType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image_type }
    end
  end

  # GET /image_types/new
  # GET /image_types/new.json
  def new
    @image_type = ImageType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image_type }
    end
  end

  # GET /image_types/1/edit
  def edit
    @image_type = ImageType.find(params[:id])
  end

  # POST /image_types
  # POST /image_types.json
  def create
    @image_type = ImageType.new(params[:image_type])

    respond_to do |format|
      if @image_type.save
        format.html { redirect_to @image_type, notice: 'Image type was successfully created.' }
        format.json { render json: @image_type, status: :created, location: @image_type }
      else
        format.html { render action: "new" }
        format.json { render json: @image_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /image_types/1
  # PUT /image_types/1.json
  def update
    @image_type = ImageType.find(params[:id])

    respond_to do |format|
      if @image_type.update_attributes(params[:image_type])
        format.html { redirect_to @image_type, notice: 'Image type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_types/1
  # DELETE /image_types/1.json
  def destroy
    @image_type = ImageType.find(params[:id])
    @image_type.destroy

    respond_to do |format|
      format.html { redirect_to image_types_url }
      format.json { head :no_content }
    end
  end
end
