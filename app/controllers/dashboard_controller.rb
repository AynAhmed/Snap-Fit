class DashboardController < ApplicationController
  def index
    calculate_net
    # Your other index action logic here
  end

  def calculate_net
    if current_user.present?
      @meals_calories = current_user.meals.sum(:nf_calories).to_i
      @workouts_calories = current_user.workouts.sum(:nf_calories).to_i
    else
      # Handle the case where there is no authenticated user
      @meals_calories = 0
      @workouts_calories = 0
    end
  
    if @meals_calories.zero? && @workouts_calories.zero?
      @net_calories = 0
    else
      @net_calories = @meals_calories - @workouts_calories
    end
  
   if @net_calories > 0 
    @remainingCal = current_user.goal.daily_calorie_goal - @net_calories
   else 
    @remainingCal = current_user.goal.daily_calorie_goal + @net_calories
   end 
  end

end
