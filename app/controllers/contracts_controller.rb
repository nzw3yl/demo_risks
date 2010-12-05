class ContractsController < ApplicationController
  before_filter :authenticate 
  before_filter :authorized_user, :only => [:create, :update, :edit]
  before_filter :admin_user, :only => :destroy

  helper_method :sort_column, :sort_direction


   def new
   @title = "Contracts"
   @contract = Contract.new
  end

  def index
    @title = "Contracts"
    @contracts = Contract.order("LOWER(" + sort_column + ") " + sort_direction)
  end

  def create
    @title = "Contracts"
    @contract = Contract.new(params[:contract])
    if @contract.save
      flash[:notice] = "successfully created Contract."
      redirect_to @contract
    else
      render :action => :new
    end
  end

  def show
   @title = "Show Contracts"
   @contract = Contract.find(params[:id])
  end

  def edit
   @title = "Contracts"
   @contract = Contract.find(params[:id])
  end

  def update
   @title = "Contracts"
     @contract = Contract.find(params[:id])
    if @contract.update_attributes(params[:contract])
      flash[:notice] = "Successfully updated contract."
      redirect_to @contract
    else
      render :action => 'edit'
    end
  end

  def destroy
   @contract.destroy
   flash[:notice] = "Successfully deleted contract."
   redirect_to contracts_path
  end

private

    def admin_user
     if current_user.admin?
       @contract = Contract.find(params[:id])
     else
       flash[:error] = "Not authorized to delete contract. Please contact an administrator"
       redirect_to contracts_path
     end
    end

    def authorized_user
     if current_user.admin? || current_user.manager?
      
     else
       flash[:error] = "Not authorized. Please contact an administrator"
       redirect_to contracts_path
     end
    end

    def sort_column
      Contract.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
