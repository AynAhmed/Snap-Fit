class CreateWorkouts < ActiveRecord::Migration[7.1]
  def change
    create_table :workouts do |t|
      t.date :log_date
      t.text :name
      t.integer :met
      t.integer :duration_min
      t.integer :nf_calories
      t.text :exercise_type
      t.text :photo_thumb_url
      t.integer :user_id

      t.timestamps
    end
  end
end
