class WorkoutsController < ApplicationController
    class WorkoutsController < ApplicationController
        before_action :set_workout, only: [:show, :edit, :update, :destroy]
      
        def index
          @workouts = Workout.all
        end
      
        def show
        end
      
        def new
          @workout = Workout.new
        end
      
        def create
          @workout = Workout.new(workout_params)
      
          if @workout.save
            redirect_to @workout, notice: 'Workout was successfully created.'
          else
            render :new
          end
        end
      
        def edit
        end
      
        def update
          if @workout.update(workout_params)
            redirect_to @workout, notice: 'Workout was successfully updated.'
          else
            render :edit
          end
        end


        def destroy
          @workout.destroy
          redirect_to workouts_url, notice: 'Workout was successfully destroyed.'
        end

        private
      
        def set_workout
          @workout = Workout.find(params[:id])
        end
      
        def workout_params
          params.require(:workout).permit(:log_date, :name, :met, :duration_min, :nf_calories, :exercise_type, :photo_thumb_url, :user_id)
        end
      end
      

end
