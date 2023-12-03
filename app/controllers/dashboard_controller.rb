class DashboardController < ApplicationController
  def index
    calculate_net
    # Your other index action logic here
  end

  def calculate_net
    @meals_calories = current_user.meals.sum(:nf_calories).to_i
    @workouts_calories = current_user.workouts.sum(:nf_calories).to_i
  
    if @meals_calories.blank? && @workouts_calories.blank?
      @net_calories = 0
    else
      @net_calories = @meals_calories - @workouts_calories
    end
  end
  
end
