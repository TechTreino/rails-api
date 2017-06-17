# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_paper_trail_whodunnit

  def user_for_paper_trail
    current_customer
  end

  def index
    render plain: 'Techtreino API'
  end
end
