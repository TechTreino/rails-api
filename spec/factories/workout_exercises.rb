# frozen_string_literal: true

FactoryGirl.define do
  factory :workout_exercise do
    sets 3
    repetitions 10

    workout
    exercise
  end
end
