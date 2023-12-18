# frozen_string_literal: true

# app/controllers/meals_controller.rb
class MealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meal, only: %i[edit update destroy]

  # GET /meals or /meals.json
  def index
    @meals = current_user.meals.all
  end

  # GET /meals/1 or /meals/1.json
  def show
    @meal = Meal.find(params[:id])
  end

  # GET /meals/new
  def new
    @meal = Meal.new
  end

  # GET /meals/1/edit
  def edit; end

  # POST /meals or /meals.json
  def create
    response = make_api_request(params[:meal][:user_input])
    meal_data = extract_data_from_api_response(response)

    meal_data.each do |data|
      puts '................................'
      puts data['serving_unit']
      puts data['serving_unit'].class
      @meal = current_user.meals.build(
        food_name: data['food_name'],
        serving_unit: data['serving_unit'],
        nf_calories: data['nf_calories'],
        serving_qty: data['serving_qty'],
        nf_saturated_fat: data['nf_saturated_fat'],
        nf_total_fat: data['nf_total_fat'],
        nf_cholesterol: data['nf_cholesterol'],
        nf_sodium: data['nf_sodium'],
        nf_total_carbohydrate: data['nf_total_carbohydrate'],
        nf_sugars: data['nf_sugars'],
        nf_protein: data['nf_protein'],
        nf_potassium: data['nf_potassium'],
        photo_thumb_url: data['photo']['thumb'],
        photo_highres_url: data['photo']['highres'],
        log_date: Date.current,
        user_input: params[:meal][:user_input],
        meal_type: params[:meal][:meal_type]
        # Add other attributes as needed
      )

      # Save each meal inside the loop
      unless @meal.save
        puts "Error saving meal: #{meal.errors.full_messages.join(', ')}"
        render :new and return
      end
    end

    puts 'All meals saved successfully!'
    redirect_to meals_path
  end

  # PATCH/PUT /meals/1 or /meals/1.json
  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to meal_url(@meal)}
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1 or /meals/1.json
  def destroy
    @meal.destroy
    respond_to do |format|
      # format.html { redirect_to meals_url, notice: "Meal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_meal
    @meal = Meal.find(params[:id])
  end

  def make_api_request(input)
    url = 'https://trackapi.nutritionix.com/v2/natural/nutrients'
    headers = {
      'Content-Type': 'application/json',
      'x-app-id': ENV['NUTRITIONIX_APP_ID'],
      'x-app-key': ENV['NUTRITIONIX_APP_KEY']
    }

    payload = {
      query: input
    }

    puts "API Request Payload: #{payload}"

    response = RestClient.post(url, payload.to_json, headers)

    JSON.parse(response.body)
  end

  def extract_data_from_api_response(response)
    response['foods']
  end

  # Only allow a list of trusted parameters through.
  def meal_params
    params.require(:meal).permit(
      :food_name,
      :serving_qty,
      :serving_unit,
      :nf_calories,
      :nf_saturated_fat,
      :nf_total_fat,
      :nf_cholesterol,
      :nf_sodium,
      :nf_total_carbohydrate,
      :nf_sugars,
      :nf_protein,
      :nf_potassium,
      :photo_thumb_url,
      :photo_highres_url,
      :user_input,
      :log_date,
      :meal_type
    )
  end
end