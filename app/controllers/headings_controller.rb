class HeadingsController < ApplicationController
  before_action :set_heading, only: %i[show edit update destroy]

  DateHeadings = Struct.new(:date, :headings)

  def home; end

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
    end_date = 2.weeks.from_now
    headings = Heading.dates_until(end_date).not_todo_or_done
    days = (DateTime.now..end_date).to_a
    @headings_by_date = days.map do |day|
      DateHeadings.new(day.to_date,
                       headings.filter do |heading|
                         heading.deadline&.to_date == day.to_date || heading.scheduled&.to_date == day.to_date
                       end)
    end
    overdue = headings.filter do |heading|
      heading.deadline&.to_date&.<(days.first.to_date) || heading.scheduled&.to_date&.<(days.first.to_date)
    end
    @headings_by_date.first.headings.unshift(*overdue)
  end

  # POST /headings or /headings.json
  def create
    @heading = Heading.new(heading_params)

    respond_to do |format|
      if @heading.save
        redirect_url = @heading.parent.nil? ? headings_url : heading_url(@heading.parent)
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
    params.require(:heading).permit(:title, :body, :status, :deadline, :scheduled, :parent_id, :heading_state_id)
  end
end
