# frozen_string_literal: true

class UserRole < ApplicationRecord
  has_paper_trail

  belongs_to :user, required: true
  belongs_to :role, required: true
end
