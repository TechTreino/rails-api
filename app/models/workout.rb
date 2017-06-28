# frozen_string_literal: true

class Workout < ApplicationRecord
  include ScopedToClient
  strip_attributes
  has_paper_trail

  validates :name, presence: true
  belongs_to :client, required: true
  belongs_to :user, required: true
  has_many :workout_exercises, dependent: :destroy
  has_many :exercises, through: :workout_exercises
end
