# frozen_string_literal: true

class GoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_goal, only: %i[show edit]

  # GET /goals or /goals.json
  def index
    @goals = current_user.goal
    #we convert the relation to an array, which should then allow you to use the group_by_day method in the view.
    @weight_logs = current_user.weight_logs.order(:log_date).to_a
    # Calculate how many days since the user created the goal
    @goal_last_updated = current_user.goal.updated_at.to_date
    @days_since_goal_updated = (Date.current - @goal_last_updated).to_i
    #calculate how many pount 
    pounds_remaining

  end

  # GET /goals/1 or /goals/1.json
  def show
    @goal = Goal.find(params[:id])
  end

  # GET /goals/new
  def new
    @goal = Goal.new
    puts "Received params: #{params.inspect}"
  end

  # GET /goals/1/edit
  def edit
    @goal = Goal.find(params[:id])
  end

 

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

# PATCH/PUT /goals/1 or /goals/1.json
  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to @goal

    else
      puts "Update failed. Errors: #{goal.errors.full_messages.inspect}"
      render :edit, status: :unprocessable_entity
    end
  end

  def goal_start_date
    @goal_start_date = current_user.goal.created_at.to_date
  end
end


def pounds_remaining
  @target = current_user.goal.target_value
  @current = current_user.goal.current_value
  @lb_remaining  = @target - @current 

end

  def weight_logs_data
    weight_logs = WeightLog.where(user_id: current_user.id).order(log_date: :asc)

    render json: weight_logs.map { |log| { log_date: log.log_date, weight: log.weight } }
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

