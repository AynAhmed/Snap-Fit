# frozen_string_literal: true

class Workout < ApplicationRecord
  belongs_to :user

  attribute :name, :string
  attribute :duration_min, :integer
  attribute :met, :float
  attribute :nf_calories, :float
  attribute :photo_thumb_url, :string
  attribute :compendium_code, :integer
  attribute :description, :text
  attribute :benefits, :text
  attribute :photo, :text
  attribute :tag_id, :integer
end
