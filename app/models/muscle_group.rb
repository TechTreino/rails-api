# frozen_string_literal: true

class MuscleGroup < ApplicationRecord
  strip_attributes

  validates :name, presence: true, uniqueness: true
end
