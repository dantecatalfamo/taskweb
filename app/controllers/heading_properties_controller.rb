class HeadingPropertiesController < ApplicationController
  before_action :set_heading_property, only: %i[show edit update destroy]

  # GET /heading_properties or /heading_properties.json
  def index
    @heading_properties = HeadingProperty.where(heading_id: params[:heading_id])
  end

  # GET /heading_properties/1 or /heading_properties/1.json
  def show; end

  # GET /heading_properties/new
  def new
    @heading_property = HeadingProperty.new
  end

  # GET /heading_properties/1/edit
  def edit; end

  # POST /heading_properties or /heading_properties.json
  def create
    @heading_property = HeadingProperty.new(heading_property_params)
    @heading = @heading_property.heading

    respond_to do |format|
      if @heading_property.save
        format.html do
          redirect_to heading_url(@heading_property.heading_id), notice: 'Heading property was successfully created.'
        end
        format.json { render :show, status: :created, location: @heading_property }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @heading_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heading_properties/1 or /heading_properties/1.json
  def update
    respond_to do |format|
      if @heading_property.update(heading_property_params)
        format.html do
          redirect_to heading_property_url(@heading_property), notice: 'Heading property was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @heading_property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @heading_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heading_properties/1 or /heading_properties/1.json
  def destroy
    @heading_property.destroy

    respond_to do |format|
      format.html { redirect_to @heading_property.heading, notice: 'Heading property was successfully destroyed.' }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_heading_property
    @heading_property = HeadingProperty.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def heading_property_params
    params.require(:heading_property).permit(:heading_id, :key, :value)
  end
end
