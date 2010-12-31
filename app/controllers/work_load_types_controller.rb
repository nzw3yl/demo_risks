class WorkLoadTypesController < ApplicationController
  helper_method :sort_column, :sort_direction 
  
  def new
   @title = "WorkLoad Types"
   @work_load_type = WorkLoadType.new
  end

  def index
    @title = "WorkLoad Types"
    @sort_attributes = "LOWER(" + sort_column + ") " + sort_direction
    @work_load_types = WorkLoadType.find(:all, :order => @sort_attributes)
  end

  def create
    @title = "WorkLoad Types"
    @work_load_type = WorkLoadType.new(params[:work_load_type])
    if @work_load_type.save
      flash[:notice] = "successfully created WorkLoad Type."
      redirect_to :root
    else
      render :action => :new
    end
  end


private

    def admin_user
     if current_user.admin?
       @work_load_type = WorkLoadType.find(params[:id])
     else
       flash[:error] = "Not authorized to delete work load type. Please contact an administrator"
       redirect_to work_load_types_path
     end
    end

    def authorized_user
     if current_user.admin? || current_user.manager?
      
     else
       flash[:error] = "Not authorized. Please contact an administrator"
       redirect_to work_load_types_path
     end
    end

    def sort_column
      WorkLoadType.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
