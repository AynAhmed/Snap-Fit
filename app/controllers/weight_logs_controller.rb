# app/controllers/weight_logs_controller.rb
class WeightLogsController < ApplicationController
  def new
    @weight_log = current_user.weight_logs.new
  end

  def create
    @weight_log = current_user.weight_logs.build(weight_log_params)
    if @weight_log.save
      redirect_to dashboard_path, notice: 'Weight logged successfully.'
    else
      render :new
    end
  end

  private

  def weight_log_params
    params.require(:weight_log).permit(:weight, :log_date)
  end
end
