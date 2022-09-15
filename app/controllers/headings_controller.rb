class HeadingsController < ApplicationController
  before_action :authorize
  before_action :set_heading, only: %i[show edit update destroy]

  # GET /headings or /headings.json
  def index
    @headings = Heading.top_level
  end

  # GET /headings/1 or /headings/1.json
  def show
    @breadcrumbs = []
    @breadcrumbs << @heading
    @breadcrumbs << @breadcrumbs.last.parent while @breadcrumbs.last.parent
    @breadcrumbs.reverse!
  end

  # GET /headings/new
  def new
    @heading = Heading.new
  end

  # GET /headings/1/edit
  def edit; end

  def agenda
    @agenda_dates = Heading.agenda_dates
  end

  # POST /headings or /headings.json
  def create
    @heading = Heading.new(heading_params)

    @heading.notebook_id = @heading.parent.notebook_id if @heading.parent_id

    respond_to do |format|
      if @heading.save
        redirect_url = @heading.parent.nil? ? notebook_url(@heading.notebook) : heading_url(@heading.parent)
        format.html { redirect_to redirect_url, notice: 'Heading was successfully created.' }
        format.json { render :show, status: :created, location: @heading }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @heading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /headings/1 or /headings/1.json
  def update
    respond_to do |format|
      if @heading.update(heading_params)
        format.html { redirect_to heading_url(@heading), notice: 'Heading was successfully updated.' }
        format.json { render :show, status: :ok, location: @heading }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @heading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /headings/1 or /headings/1.json
  def destroy
    @heading.destroy

    respond_to do |format|
      format.html { redirect_to headings_url, notice: 'Heading was successfully destroyed.' }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_heading
    @heading = Heading.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def heading_params
    params.require(:heading).permit(:title, :body, :status, :deadline, :scheduled, :parent_id, :heading_state_id,
                                    :notebook_id)
  end
end
