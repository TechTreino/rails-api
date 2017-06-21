# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  include ScopedToClient

  strip_attributes
  has_paper_trail
  serialize :roles, Array
  validates :first_name, presence: true
  validates :last_name, presence: true
  before_create :set_default_roles

  belongs_to :client

  private

  def set_default_roles
    self.roles = [:customer] if roles.blank?
  end
end
