class User < ApplicationRecord
  has_one :goal, dependent: :destroy
  has_many :meals, dependent: :destroy
  has_many :workouts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
