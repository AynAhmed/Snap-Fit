class Goal < ApplicationRecord
  belongs_to :workout
  belongs_to :meal
end
