# frozen_string_literal: true

class Exercise < ApplicationRecord
  strip_attributes

  belongs_to :muscle_group
  validates :name, presence: true, uniqueness: true
end
