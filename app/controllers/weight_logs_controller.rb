# app/controllers/weight_logs_controller.rb
class WeightLogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @weight_logs = current_user.weight_logs.all
   
  end 
  
  def show
    @weight_log = WeightLog.find(params[:id])
  end

  def new
    @weight_log = current_user.weight_logs.new if current_user.present?
  end

  def create
    @weight_log = current_user.weight_logs.build(weight_log_params)
    if @weight_log.save
      redirect_to weight_logs_path
    else
      render :new
    end
  end

  def edit
    @weight_log = WeightLog.find(params[:id])
  end


  def update
    @weight_log = WeightLog.find(params[:id])

    if @weight_log.update(weight_log_params)
      redirect_to @weight_log
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @weight_log = WeightLog.find(params[:id])
    @weight_log.destroy

    redirect_to weight_logs_path, status: :see_other
  end

  private

  def weight_log_params
    params.require(:weight_log).permit(:weight, :log_date)
  end
end
