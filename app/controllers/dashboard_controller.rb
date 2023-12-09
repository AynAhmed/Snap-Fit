# frozen_string_literal: true

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

    @net_calories = if @meals_calories.zero? && @workouts_calories.zero?
                      0
                    else
                      @meals_calories - @workouts_calories
                    end

    @remainingCal = if @net_calories.positive?
                      current_user.goal.daily_calorie_goal - @net_calories
                    else
                      current_user.goal.daily_calorie_goal + @net_calories
                    end
  end
end
