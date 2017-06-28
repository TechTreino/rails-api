# frozen_string_literal: true

json.workout do
  json.partial! 'workouts/workout', workout: @view.workout
end
