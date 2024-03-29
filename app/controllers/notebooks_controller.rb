class NotebooksController < ApplicationController
  before_action :set_notebook, only: %i[show edit update destroy]

  # GET /notebooks or /notebooks.json
  def index
    @notebooks = Notebook.where(user: current_user)
  end

  # GET /notebooks/1 or /notebooks/1.json or /notebooks/1.org
  def show
    respond_to do |format|
      format.html
      format.json
      format.org { response.headers['Content-Disposition'] = "filename=\"#{@notebook.title}.org\"" }
    end
  end

  # GET /notebooks/new
  def new
    @notebook = Notebook.new
  end

  # GET /notebooks/1/edit
  def edit; end

  # POST /notebooks or /notebooks.json
  def create
    @notebook = Notebook.new(notebook_params)
    @notebook.user = current_user

    respond_to do |format|
      if @notebook.save
        format.html { redirect_to notebook_url(@notebook), notice: 'Notebook was successfully created.' }
        format.json { render :show, status: :created, location: @notebook }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @notebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notebooks/1 or /notebooks/1.json
  def update
    respond_to do |format|
      if @notebook.update(notebook_params)
        format.html { redirect_to notebooks_url, notice: 'Notebook was successfully updated.' }
        format.json { render :show, status: :ok, location: @notebook }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @notebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notebooks/1 or /notebooks/1.json
  def destroy
    @notebook.destroy

    respond_to do |format|
      format.html { redirect_to notebooks_url, notice: 'Notebook was successfully destroyed.' }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_notebook
    @notebook = Notebook.find_by!(id: params[:id], user: current_user)
  end

  # Only allow a list of trusted parameters through.
  def notebook_params
    params.require(:notebook).permit(:title)
  end
end
