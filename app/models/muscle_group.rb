# frozen_string_literal: true

class MuscleGroup < ApplicationRecord
  strip_attributes

  has_many :exercises_muscle_groups
  has_many :exercises, through: :exercises_muscle_groups
  validates :name, presence: true
end
