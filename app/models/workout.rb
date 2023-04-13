class Workout < ApplicationRecord
    def index
        @workouts = Workout.all
    end
    def show
        @workout = Workout.find(params[:id])
    end
end
