# frozen_string_literal: true

class WorkoutsController < ApplicationController
  before_action :set_workout, only: %i[show update destroy]

  def index
    @view = OpenStruct.new(workouts: Workout.by_client)
  end

  def show
    @view = OpenStruct.new(workout: @workout)
  end

  def create
    @workout = Workout.new(workout_params.merge(client_id: current_user.client.id))
    set_workout_exercises

    if @workout.save
      @view = OpenStruct.new(workout: @workout)
    else
      render_validation_errors(@workout)
    end
  end

  def update
    set_workout_exercises

    if @workout.update(workout_params)
      @view = OpenStruct.new(workout: @workout)
    else
      render_validation_errors(@workout)
    end
  end

  def destroy
    @workout.destroy
    render body: nil, status: :no_content
  end

  private

  def set_workout
    @workout = Workout.by_client.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(:name, :user_id)
  end

  def set_workout_exercises
    return unless params[:workout][:workout_exercises]

    @workout.workout_exercises = params[:workout][:workout_exercises].map do |workout_exercise_data|
      workout_exercise = WorkoutExercise.find_by(id: workout_exercise_data[:id])
      if workout_exercise
        workout_exercise.update!(workout_exercise_params(workout_exercise_data))
      else
        workout_exercise ||= WorkoutExercise.new(workout_exercise_params(workout_exercise_data))
      end

      workout_exercise
    end
  end

  def workout_exercise_params(workout_exercise_data)
    workout_exercise_data.permit(:exercise_id, :sets, :repetitions)
  end
end
