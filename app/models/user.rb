# frozen_string_literal: true

class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User
  include ScopedToClient

  has_paper_trail
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  before_create :skip_duplicate_devise_confirmation_email

  belongs_to :client

  # Fixes problem with duplicate account confirmation emails
  def skip_duplicate_devise_confirmation_email
    skip_confirmation_notification!
  end
end
