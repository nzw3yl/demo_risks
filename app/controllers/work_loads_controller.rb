class WorkLoadsController < ApplicationController
  def new
   @work_load = WorkLoad.new
  end

  def index
   @work_loads = WorkLoad.find(:all)
  end

  def create
   @work_load = WorkLoad.create(params[:work_load])
    if @work_load.save
      flash[:success] = "Workload Created"
      redirect_to @work_load
    else
      @title = "Create Work"
      render :new
    end
  end

  def destroy
  end

  def show
  end

  def edit
  end

  def update
  end

end
