class WeightLog < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  validates :image, presence: true 
  validates :weight, presence: true
  validates :log_date, presence: true
end
