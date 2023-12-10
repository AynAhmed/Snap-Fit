# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    recalculate_daily_summary
    # Your other index action logic here
  end

  private

  def recalculate_daily_summary
    if current_user.present?
      # Fetch meals and workouts for the current date
      meals = current_user.meals.where(log_date: Date.current.beginning_of_day..Date.current.end_of_day)
      workouts = current_user.workouts.where(log_date: Date.current.beginning_of_day..Date.current.end_of_day)

      # Calculate calories for meals and workouts
      meals_calories = meals.sum(:nf_calories).to_i
      workouts_calories = workouts.sum(:nf_calories).to_i

      # Calculate net calories and remaining calories
      net_calories = meals_calories - workouts_calories
      remaining_calories = if net_calories.positive?
                             current_user.goal.daily_calorie_goal - net_calories
                           else
                             current_user.goal.daily_calorie_goal + net_calories
                           end

      # Update instance variables for the view
      @meals_calories = meals_calories
      @workouts_calories = workouts_calories
      @net_calories = net_calories
      @remainingCal = remaining_calories
    else
      # Handle the case where there is no authenticated user
      @meals_calories = 0
      @workouts_calories = 0
      @net_calories = 0
      @remainingCal = 0
    end
  end
end

