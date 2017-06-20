# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  include ScopedToClient

  strip_attributes
  has_paper_trail
  # Include default devise modules.
  serialize :roles, Array
  validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :client
end
