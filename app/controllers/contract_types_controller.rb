class ContractTypesController < ApplicationController

  helper_method :sort_column, :sort_direction 
  
  def new
   @title = "Contract Types"
   @contract_type = ContractType.new
  end

  def index
    @title = "Contract Types"
    @sort_attributes = "LOWER(" + sort_column + ") " + sort_direction
    @contract_types = ContractType.find(:all, :order => @sort_attributes)
  end

  def create
    @title = "Contract Types"
    @contract_type = ContractType.new(params[:contract_type])
    if @contract_type.save
      flash[:notice] = "successfully created Contract Type."
      redirect_to :root
    else
      render :action => :new
    end
  end


private

    def admin_user
     if current_user.admin?
       @contract_type = ContractType.find(params[:id])
     else
       flash[:error] = "Not authorized to delete contract type. Please contact an administrator"
       redirect_to contract_types_path
     end
    end

    def authorized_user
     if current_user.admin? || current_user.manager?
      
     else
       flash[:error] = "Not authorized. Please contact an administrator"
       redirect_to contract_types_path
     end
    end

    def sort_column
      ContractType.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
