# frozen_string_literal: true

class Meal < ApplicationRecord
  belongs_to :user

  attribute :compendium_code, :integer
end
