class CountdownImageDescriptorsController < ApplicationController
  before_action :set_countdown_image_descriptor, only: [:show, :edit, :update, :destroy]

  # GET /countdown_image_descriptors
  # GET /countdown_image_descriptors.json
  def index
    @countdown_image_descriptors = CountdownImageDescriptor.all
  end

  # GET /countdown_image_descriptors/1
  # GET /countdown_image_descriptors/1.json
  def show
  end

  # GET /countdown_image_descriptors/new
  def new
    @countdown_image_descriptor = CountdownImageDescriptor.new
  end

  # GET /countdown_image_descriptors/1/edit
  def edit
  end

  # POST /countdown_image_descriptors
  # POST /countdown_image_descriptors.json
  def create
    @countdown_image_descriptor = CountdownImageDescriptor.new(countdown_image_descriptor_params)

    respond_to do |format|
      if @countdown_image_descriptor.save
        format.html { redirect_to @countdown_image_descriptor, notice: 'Countdown image descriptor was successfully created.' }
        format.json { render action: 'show', status: :created, location: @countdown_image_descriptor }
      else
        format.html { render action: 'new' }
        format.json { render json: @countdown_image_descriptor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /countdown_image_descriptors/1
  # PATCH/PUT /countdown_image_descriptors/1.json
  def update
    respond_to do |format|
      if @countdown_image_descriptor.update(countdown_image_descriptor_params)
        format.html { redirect_to @countdown_image_descriptor, notice: 'Countdown image descriptor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @countdown_image_descriptor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /countdown_image_descriptors/1
  # DELETE /countdown_image_descriptors/1.json
  def destroy
    @countdown_image_descriptor.destroy
    respond_to do |format|
      format.html { redirect_to countdown_image_descriptors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_countdown_image_descriptor
      @countdown_image_descriptor = CountdownImageDescriptor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def countdown_image_descriptor_params
      params.require(:countdown_image_descriptor).permit(:background_image, :background_color, :text_color, :pointsize, :font_weight, :width, :height, :days_position_x, :days_position_y, :hours_position_x, :hours_position_y, :minutes_position_x, :minutes_position_y, :seconds_position_x, :seconds_position_y)
    end
end
