class WorkLoadsController < ApplicationController

  before_filter :authenticate 
  before_filter :authorized_user, :only => [:create, :update, :edit]
  before_filter :admin_user, :only => :destroy

  helper_method :sort_column, :sort_direction

  def new
   @work_load = WorkLoad.new
   new_form_defaults
  end

  def index
   @work_loads = WorkLoad.find(:all)
   @sort_attributes = "LOWER(" + sort_column + ") " + sort_direction
   @contracts = WorkLoad.find(:all, :order => @sort_attributes)
  end

  def create
   @work_load = WorkLoad.new(params[:work_load])
    if @work_load.save #(:validate => false) # :( yuck! a poor hack
      flash[:success] = "Workload Created"
      redirect_to @work_load
    else
      @title = "Create Work"
      render :new
    end
  end

  def destroy
   @work_load.destroy
   flash[:notice] = "Successfully deleted work load."
   redirect_to work_loads_path
  end

  def show
   @work_load = WorkLoad.find(params[:id])
  end

  def edit
   @work_load = WorkLoad.find(params[:id])
   #@work_load.contract_ids = Obligation.find_all_by_work_load_id(:work_loads)
  end

  def update
     @work_load = WorkLoad.find(params[:id])
    if @work_load.update_attributes(params[:work_load])
      flash[:notice] = "Successfully updated work load."
      redirect_to @work_load
    else
      render :action => 'edit'
    end
  end

  private

    def admin_user
     if current_user.admin?
      @work_load = WorkLoad.find(params[:id])
     else
       flash[:error] = "Not authorized to delete work load. Please contact an administrator"
       redirect_to workloads_path
     end
    end

    def authorized_user
     if current_user.admin? || current_user.manager?
      
     else
       flash[:error] = "Not authorized. Please contact an administrator"
       redirect_to work_loads_path
     end
    end

    def sort_column
      WorkLoad.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def new_form_defaults
      @work_load.status = "Inactive"
      @work_load.probability = 0
      @work_load.impact = 0
    end

end
