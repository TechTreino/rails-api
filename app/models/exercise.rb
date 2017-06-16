# frozen_string_literal: true

class Exercise < ApplicationRecord
  strip_attributes
  has_paper_trail

  belongs_to :muscle_group, required: true
  validates :name, presence: true, uniqueness: true
end
