# frozen_string_literal: true

class ExercisesController < ApplicationController
  include Authenticable

  def index
    @view = OpenStruct.new(exercises: Exercise.by_client.all)
  end

  def show
    @exercise = Exercise.by_client.find(params[:id])

    exercise_show
  end

  def create
    @exercise = Exercise.create!(exercise_params.merge(client_id: current_user.client.id))

    exercise_show
  end

  def update
    @exercise = Exercise.by_client.find(params[:id])
    @exercise.update!(exercise_params)
    exercise_show
  end

  def destroy
    @exercise = Exercise.by_client.find(params[:id])

    @exercise.destroy
    render body: nil, status: :no_content
  end

  private

  def exercise_show
    @view = OpenStruct.new(exercise: @exercise)

    render :show
  end

  def exercise_params
    params.require(:exercise).permit(:name, :muscle_group_id)
  end
end
