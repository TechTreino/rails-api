# frozen_string_literal: true

class Exercise < ApplicationRecord
  include ScopedToClient
  strip_attributes
  has_paper_trail

  belongs_to :muscle_group, required: true
  belongs_to :client, required: true
  validates :name, presence: true, uniqueness: true
end
