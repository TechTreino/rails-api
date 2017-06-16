# frozen_string_literal: true

class Customer < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  has_paper_trail
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
end
