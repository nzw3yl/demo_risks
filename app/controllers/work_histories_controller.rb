class WorkHistoriesController < ApplicationController
  helper_method :sort_column, :sort_direction 
  
  def new
   @title = "Work History"
   @work_load = WorkLoad.find(params[:work_load_id])
   @work_history = @work_load.work_histories.build
   @work_load_type = WorkLoadType.find_by_id(@work_load.work_load_type_id)
   #@disabled_contracts = Obligation.find(:all, :select => "contract_id", :conditions =>['work_load_id <> ?', @work_load.id]).map(&:contract_id)
   @disabled_contracts = Array.new
   @all_contracts = Contract.find(:all, :select => "id").map(&:id)
   @all_contracts.each do |ac|
      @related_contract = Obligation.find_by_contract_id_and_work_load_id(ac, @work_load.id) 
      @disabled_contracts << ac unless @related_contract
   end
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
    @assignment = Assignment.find_by_user_id_and_work_load_id(current_user.id, @work_load.id)
    @contract_array = params[:work_history][:work_load][:contract_ids]
    @clean_contract = @contract_array.compact.reject(&:blank?)
   
    if @contract_array.size > 0 
       @equal_effort = params[:work_history][:effort].to_f / @contract_array.size
       @contract_names = Array.new
    end
    @contract_array.each do |ca| 
        @obligation = Obligation.find_by_contract_id_and_work_load_id(ca, @work_load.id)
        if @obligation
           @contract_names << Contract.find_by_id(ca).alias
           @obligation.update_effort(@equal_effort)
        end
    end
    @work_history.contract_name = @contract_names.join(",")
    @work_history.contract_ids = @clean_contract.join(",")
    if @work_history.save
      @work_load.set_resolution_effort
      if @assignment
         @assignment.set_effort
      end
      flash[:notice] = "successfully recorded effort."
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


end
