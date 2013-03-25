class ActionNamesController < ApplicationController
  before_action :set_action_name, only: [:show, :edit, :update, :destroy]

  # GET /action_names
  # GET /action_names.json
  def index
    @action_names = ActionName.all
  end

  # GET /action_names/1
  # GET /action_names/1.json
  def show
  end

  # GET /action_names/new
  def new
    @action_name = ActionName.new
  end

  # GET /action_names/1/edit
  def edit
  end

  # POST /action_names
  # POST /action_names.json
  def create
    @action_name = ActionName.new(action_name_params)

    respond_to do |format|
      if @action_name.save
        format.html { redirect_to @action_name, notice: 'Action name was successfully created.' }
        format.json { render action: 'show', status: :created, location: @action_name }
      else
        format.html { render action: 'new' }
        format.json { render json: @action_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /action_names/1
  # PATCH/PUT /action_names/1.json
  def update
    respond_to do |format|
      if @action_name.update(action_name_params)
        format.html { redirect_to @action_name, notice: 'Action name was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @action_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /action_names/1
  # DELETE /action_names/1.json
  def destroy
    @action_name.destroy
    respond_to do |format|
      format.html { redirect_to action_names_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_action_name
      @action_name = ActionName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def action_name_params
      params.require(:action_name).permit(:name)
    end
end
