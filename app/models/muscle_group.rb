# frozen_string_literal: true

class MuscleGroup < ApplicationRecord
  strip_attributes
  has_paper_trail

  validates :name, presence: true, uniqueness: true
end
