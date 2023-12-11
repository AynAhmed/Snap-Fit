class WeightLog < ApplicationRecord
  belongs_to :user
  validates :weight, presence: true
  validates :log_date, presence: true
end
