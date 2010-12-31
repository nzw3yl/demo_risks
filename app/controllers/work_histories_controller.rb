class WorkHistoriesController < ApplicationController
  helper_method :sort_column, :sort_direction 
  
  def new
   @title = "Work History"
   @work_load = WorkLoad.find(params[:work_load_id])
   @work_history = @work_load.work_histories.build
   @work_load_type = WorkLoadType.find_by_id(@work_load.work_load_type_id)
   if @work_load_type
      @work_load_type_name = @work_load_type.name
   else
      @work_load_type_name = WorkLoadType.find(:first).name
   end
  end

  def index
    @title = "Work History"
    @work_load = WorkLoad.find(params[:work_load_id])
    @sort_attributes = "LOWER(" + sort_column + ") " + sort_direction
    @work_histories = @work_load.work_histories.find(:all, :order => @sort_attributes)
  end

  def create
    @title = "Work History"
    @work_load = WorkLoad.find(params[:work_load_id])
    @work_history = @work_load.work_histories.build(params[:work_history])
    if @work_history.save
      update_accumulated_work_load_hours @work_history.work_load_id
      flash[:notice] = "successfully created WorkLoad Type."
      redirect_to work_load_url(@work_history.work_load_id)
    else
      render :action => :new
    end
  end


private


    def sort_column
      WorkHistory.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def update_accumulated_work_load_hours(work_load_id)
       @work_load = WorkLoad.find_by_id(work_load_id)
       @work_load.resolution_effort = WorkHistory.sum(:effort, :conditions => ['work_load_id = ?', work_load_id])
       @work_load.save
    end


end
