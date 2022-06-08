class HeadingStatesController < ApplicationController
  before_action :set_heading_state, only: %i[ show edit update destroy ]

  # GET /heading_states or /heading_states.json
  def index
    @heading_states = HeadingState.all
  end

  # GET /heading_states/1 or /heading_states/1.json
  def show
  end

  # GET /heading_states/new
  def new
    @heading_state = HeadingState.new
  end

  # GET /heading_states/1/edit
  def edit
  end

  # POST /heading_states or /heading_states.json
  def create
    @heading_state = HeadingState.new(heading_state_params)

    respond_to do |format|
      if @heading_state.save
        format.html { redirect_to heading_state_url(@heading_state), notice: "Heading state was successfully created." }
        format.json { render :show, status: :created, location: @heading_state }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @heading_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heading_states/1 or /heading_states/1.json
  def update
    respond_to do |format|
      if @heading_state.update(heading_state_params)
        format.html { redirect_to heading_state_url(@heading_state), notice: "Heading state was successfully updated." }
        format.json { render :show, status: :ok, location: @heading_state }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @heading_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heading_states/1 or /heading_states/1.json
  def destroy
    @heading_state.destroy

    respond_to do |format|
      format.html { redirect_to heading_states_url, notice: "Heading state was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heading_state
      @heading_state = HeadingState.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def heading_state_params
      params.require(:heading_state).permit(:name, :done)
    end
end
