class CreateMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :meals do |t|
      t.text :food_name
      t.integer :serving_qty
      t.text :serving_unit
      t.decimal :nf_calories
      t.decimal :nf_saturated_fat
      t.decimal :nf_total_fat
      t.decimal :nf_cholesterol
      t.decimal :nf_sodium
      t.decimal :nf_total_carbohydrate
      t.decimal :nf_sugars
      t.decimal :nf_protein
      t.decimal :nf_potassium
      t.text :photo_thumb_url
      t.text :photo_highres_url
      t.date :log_date
      t.text :meal_type
      t.text :user_input
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
