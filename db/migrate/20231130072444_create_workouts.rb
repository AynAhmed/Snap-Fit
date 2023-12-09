# frozen_string_literal: true

class CreateWorkouts < ActiveRecord::Migration[7.1]
  def change
    create_table :workouts do |t|
      t.date :log_date
      t.text :name
      t.float :met
      t.text :user_input
      t.integer :duration_min
      t.float :nf_calories
      t.integer :user_id

      t.timestamps
    end
  end
end
