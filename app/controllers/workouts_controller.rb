# frozen_string_literal: true

class WorkoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workout, only: %i[ show destroy]

  def index
    @workouts = current_user.workouts.all
  end

  def show
   
  end

  def new
    @workout = Workout.new
  end

  def create
    response = make_api_request(params[:workout][:user_input])
    workout_data = extract_data_from_api_response(response)

    workout_data.each do |data|
      @workout = current_user.workouts.build(
        log_date: Date.current,
        name: data['name'],
        duration_min: data['duration_min'],
        met: data['met'],
        user_input: data['user_input'],
        nf_calories: data['nf_calories']
        # Add other attributes as needed
      )

      # Save each workout inside the loop
      unless @workout.save
        puts "Error saving workout: #{@workout.errors.full_messages.join(', ')}"
        render :new and return
      end
    end

    puts 'All workouts saved successfully!'
    redirect_to workouts_path, notice: 'Workouts logged successfully.'
  end

  

  def destroy
    @workout.destroy
    respond_to do |format|
      # format.html { redirect_to meals_url, notice: "Meal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_workout
    @workout = Workout.find(params[:id])
  end

  def make_api_request(input)
    url = 'https://trackapi.nutritionix.com/v2/natural/exercise'
    headers = {
      'Content-Type': 'application/json',
      'x-app-id': ENV['NUTRITIONIX_APP_ID'],
      'x-app-key': ENV['NUTRITIONIX_APP_KEY']
    }

    payload = {
      query: input
    }

    response = RestClient.post(url, payload.to_json, headers)

    JSON.parse(response.body)
  end

  def extract_data_from_api_response(response)
    response['exercises']
  end

  def workout_params
    params.require(:workout).permit(:user_input, :log_date, :name, :duration_min, :met, :nf_calories)
  end
end
