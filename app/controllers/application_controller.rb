# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :authenticate_customer!, except: :index

  def user_for_paper_trail
    current_customer
  end

  def index
    a = MuscleGroup.new(name: 'blau')
    a.save!
    render plain: 'Techtreino API'
  end
end
