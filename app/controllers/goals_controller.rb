# frozen_string_literal: true

class GoalsController < ApplicationController
  before_action :set_goal, only: %i[show edit]

  # GET /goals or /goals.json
  def index
    @goals = current_user.goal
    #we convert the relation to an array, which should then allow you to use the group_by_day method in the view.
    @weight_logs = current_user.weight_logs.order(:log_date).to_a

  end

  # GET /goals/1 or /goals/1.json
  def show
    @goal = Goal.find(params[:id])
    @weight_logs = current_user.weight_logs.order(:log_date)
  end

  # GET /goals/new
  def new
    @goal = Goal.new
  end

  # GET /goals/1/edit
  def edit; end

  # POST /goals or /goals.json
  def create
    @goal = current_user.build_goal(goal_params)
    puts "Received params: #{params.inspect}"
  
    respond_to do |format|
      if @goal.save
        format.html { redirect_to dashboard_index_path, notice: 'Goal was successfully created.' }
      else
        puts "Errors: #{@goal.errors.full_messages.inspect}"
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def weight_logs_data
    weight_logs = WeightLog.where(user_id: current_user.id).order(log_date: :asc)

    render json: weight_logs.map { |log| { log_date: log.log_date, weight: log.weight } }
  end

  # PATCH/PUT /goals/1 or /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to goal_url(@goal), notice: 'Goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @goal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /goals/1 or /goals/1.json
  def destroy
    @goal.destroy!

    respond_to do |format|
      format.html { redirect_to goals_url, notice: 'Goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private



  def goal_params
    params.require(:goal).permit(:goal_type, :target_value, :current_value, :daily_calorie_goal)
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_goal
    @goal = Goal.find(params[:id])
  end
end
