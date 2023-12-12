# frozen_string_literal: true

class WelcomeController < ApplicationController

  before_action :redirect_to_goal, if: -> { user_signed_in? }

  def index
    @user = current_user if user_signed_in?
  end

  private

  def redirect_to_goal
    user_goal = current_user.goal

    if user_goal.present? && user_goal.goal_type.present? &&
       user_goal.target_value.present? && user_goal.current_value.present? &&
       user_goal.daily_calorie_goal.present?
      redirect_to dashboard_index_path
    else
      redirect_to new_goal_path, alert: 'Please fill in your goal details before proceeding.'
    end
  end
end
