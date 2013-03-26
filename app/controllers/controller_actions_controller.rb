class ControllerActionsController < ApplicationController
  before_action :set_controller_action, only: [:show, :edit, :update, :destroy]
  before_filter :process_permissions_attrs, only: [:create, :update, :update_multiple]

  def process_permissions_attrs
    if params[:controller_action].is_a? Hash  # Single
      params[:controller_action][:interactions_attributes].values.each do |per_attr|
        per_attr[:_destroy] = true if per_attr[:enable] != '1'
      end
      a=1
    else # collection
    end
  end

  # GET /controller_actions
  # GET /controller_actions.json
  def index
    @actions = ActionName.all
    @controllers = ControllerName.all
    @controller_actions = ControllerAction.all
  end

  # GET /controller_actions/1
  # GET /controller_actions/1.json
  def show
  end

  # GET /controller_actions/new
  def new
    @controller_action = ControllerAction.new
  end

  # GET /controller_actions/1/edit
  def edit
  end

  # POST /controller_actions
  # POST /controller_actions.json
  def create
    @controller_action = ControllerAction.new(controller_action_params)

    respond_to do |format|
      if @controller_action.save
        format.html { redirect_to @controller_action, notice: 'Controller action was successfully created.' }
        format.json { render action: 'show', status: :created, location: @controller_action }
      else
        format.html { render action: 'new' }
        format.json { render json: @controller_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controller_actions/1
  # PATCH/PUT /controller_actions/1.json
  def update
    respond_to do |format|
      if @controller_action.update(controller_action_params)
        format.html { redirect_to @controller_action, notice: 'Controller action was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @controller_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controller_actions/1
  # DELETE /controller_actions/1.json
  def destroy
    @controller_action.destroy
    respond_to do |format|
      format.html { redirect_to controller_actions_url }
      format.json { head :no_content }
    end
  end


  def edit_multiple
    if params[:commit] == 'Edit Action'
      @title = "Editing action " + ActionName.find(params[:actions]).name.capitalize + " for all Controllers"
      @controller_actions = ControllerAction.actions(params[:actions]).all
    else
      @title = "Editing controller " + ControllerName.find(params[:controllers]).name.capitalize + " for all Actions"
      @controller_actions = ControllerAction.controllers(params[:controllers]).all
    end
  end

  def update_multiple
    @controller_actions = ControllerAction.find(params[:controller_action_ids])
    ControllerAction.where(:id => params[:controller_action_ids].collect {|id| id.to_i}).update_all(params[:controller_action]) #.update_all(params[:controller_action])
    @controller_actions.each do |ca|
      @res = ca.update_attributes(params[:controller_action])
    end

    @controller_actions = ControllerAction.update(params[:controller_action][:interactions_attributes].keys, params[:controller_action][:interactions_attributes].values).reject { |p| p.errors.empty? }
                                                                                                                                #params[:controller_action][:interactions_attributes].fetch('0').delete("id")
                                                                                                                                #@controller_actions.each do |controller_action|
                                                                                                                                #     @ca = ControllerAction.update(params[:controller_action][:interactions_attributes].values,params[:controller_action][:interactions_attributes].keys)  #.reject { |k,v| v.blank? })
                                                                                                                                #end
    params[:controller_action][:interactions_attributes].each do |attrs|
      @controller_action = ControllerAction.find(attrs[1].fetch("id"))
      @controller_actions << @controller_action.update_attributes(params[:controller_attribute])
      #(attrs[1].values, attrs[1].keys.collect {|k| k.to_s}) #.reject { |p| p.errors.empty? }
    end

    respond_to do |format|
      if @controller_actions.update_attributes(params[:controller_action])
        format.html { redirect_to @controller_action, notice: 'Controller action was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @controller_action.errors, status: :unprocessable_entity }
      end
    end
    if @controller_actions.empty?
      flash[:notice] = "Products updated"
      redirect_to products_url
    else
      render :action => "edit_individual"
    end
    @controller_actions = ControllerAction(params[:controller_action]).all
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controller_action
      @controller_action = ControllerAction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controller_action_params
      params.require(:controller_action).permit!
    end
end
