# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  include ScopedToClient

  strip_attributes
  has_paper_trail
  has_many :user_roles
  has_many :roles, through: :user_roles
  validates :first_name, presence: true
  validates :last_name, presence: true
  before_create :set_default_roles

  belongs_to :client, required: true

  private

  def set_default_roles
    self.roles = [Role.customer] if roles.blank?
  end
end
