# frozen_string_literal: true

json.workouts do
  json.partial! 'workouts/workout', collection: @view.workouts, as: :workout
end
