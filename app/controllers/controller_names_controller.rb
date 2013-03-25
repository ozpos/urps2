class ControllerNamesController < ApplicationController
  before_action :set_controller_name, only: [:show, :edit, :update, :destroy]

  # GET /controller_names
  # GET /controller_names.json
  def index
    @controller_names = ControllerName.all
  end

  # GET /controller_names/1
  # GET /controller_names/1.json
  def show
  end

  # GET /controller_names/new
  def new
    @controller_name = ControllerName.new
  end

  # GET /controller_names/1/edit
  def edit
  end

  # POST /controller_names
  # POST /controller_names.json
  def create
    @controller_name = ControllerName.new(controller_name_params)

    respond_to do |format|
      if @controller_name.save
        format.html { redirect_to @controller_name, notice: 'Controller name was successfully created.' }
        format.json { render action: 'show', status: :created, location: @controller_name }
      else
        format.html { render action: 'new' }
        format.json { render json: @controller_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controller_names/1
  # PATCH/PUT /controller_names/1.json
  def update
    respond_to do |format|
      if @controller_name.update(controller_name_params)
        format.html { redirect_to @controller_name, notice: 'Controller name was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @controller_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controller_names/1
  # DELETE /controller_names/1.json
  def destroy
    @controller_name.destroy
    respond_to do |format|
      format.html { redirect_to controller_names_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controller_name
      @controller_name = ControllerName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controller_name_params
      params.require(:controller_name).permit(:name)
    end
end
