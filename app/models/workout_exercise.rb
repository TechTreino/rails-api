# frozen_string_literal: true

class WorkoutExercise < ApplicationRecord
  strip_attributes
  has_paper_trail

  belongs_to :workout, required: true
  belongs_to :exercise, required: true
  validates :sets, presence: true
  validates :repetitions, presence: true
end
