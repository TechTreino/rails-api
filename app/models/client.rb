# frozen_string_literal: true

class Client < ApplicationRecord
  strip_attributes
  has_paper_trail

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
