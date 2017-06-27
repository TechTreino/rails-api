# frozen_string_literal: true

class Role < ApplicationRecord
  strip_attributes
  has_paper_trail

  has_many :user_roles
  has_many :users, through: :user_roles

  validates :name, presence: true, uniqueness: true

  def self.system_admin
    Role.find_or_create_by(name: 'system_admin')
  end

  def self.client_admin
    Role.find_or_create_by(name: 'client_admin')
  end

  def self.customer
    Role.find_or_create_by(name: 'customer')
  end
end
