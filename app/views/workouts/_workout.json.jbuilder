# frozen_string_literal: true

json.extract! workout, :id, :user_id, :name, :created_at, :updated_at

json.workout_exercises do
  json.partial! 'workout_exercises/workout_exercise', collection: workout.workout_exercises, as: :workout_exercise
end
