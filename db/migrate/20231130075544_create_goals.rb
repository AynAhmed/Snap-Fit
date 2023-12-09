# frozen_string_literal: true

class CreateGoals < ActiveRecord::Migration[7.1]
  def change
    create_table :goals do |t|
      t.text :goal_type
      t.integer :target_value
      t.integer :current_value
      t.integer :daily_calorie_goal
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
