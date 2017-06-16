# frozen_string_literal: true

class Exercise < ApplicationRecord
  strip_attributes

  has_many :exercises_muscle_groups
  has_many :muscle_groups, through: :exercises_muscle_groups
  validates :name, presence: true
end
