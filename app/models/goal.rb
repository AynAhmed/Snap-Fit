class Goal < ApplicationRecord
  belongs_to :user

  validates :goal_type, presence: true
  validates :target_value, presence: true, numericality: { greater_than: 0 }
  validates :current_value, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :daily_calorie_goal, presence: true, numericality: { greater_than: 0 }

  validate :user_has_no_goal, on: :create
end
