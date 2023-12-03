# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_30_075544) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "goals", force: :cascade do |t|
    t.text "goal_type"
    t.integer "target_value"
    t.integer "current_value"
    t.integer "daily_calorie_goal"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "meals", force: :cascade do |t|
    t.text "food_name"
    t.text "serving_qty"
    t.text "serving_unit"
    t.decimal "nf_calories"
    t.decimal "nf_saturated_fat"
    t.decimal "nf_total_fat"
    t.decimal "nf_cholesterol"
    t.decimal "nf_sodium"
    t.decimal "nf_total_carbohydrate"
    t.decimal "nf_sugars"
    t.decimal "nf_protein"
    t.decimal "nf_potassium"
    t.text "photo_thumb_url"
    t.date "log_date"
    t.text "meal_type"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workouts", force: :cascade do |t|
    t.date "log_date"
    t.text "name"
    t.integer "met"
    t.integer "duration_min"
    t.integer "nf_calories"
    t.text "exercise_type"
    t.text "photo_thumb_url"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "goals", "users"
  add_foreign_key "meals", "users"
end
