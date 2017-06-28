# frozen_string_literal: true

class ExercisesController < ApplicationController
  include Authenticable
  before_action :set_exercise, only: %i[show update destroy]

  def index
    @view = OpenStruct.new(exercises: Exercise.by_client.all)
  end

  def show
    render_show_exercise
  end

  def create
    @exercise = Exercise.new(exercise_params.merge(client_id: current_user.client.id))

    if @exercise.save
      render_show_exercise
    else
      render_validation_errors(@exercise)
    end
  end

  def update
    if @exercise.update(exercise_params)
      render_show_exercise
    else
      render_validation_errors(@exercise)
    end
  end

  def destroy
    @exercise.destroy
    render body: nil, status: :no_content
  end

  private

  def set_exercise
    @exercise = Exercise.by_client.find(params[:id])
  end

  def render_show_exercise
    @view = OpenStruct.new(exercise: @exercise)

    render :show
  end

  def exercise_params
    params.require(:exercise).permit(:name, :muscle_group_id)
  end
end
