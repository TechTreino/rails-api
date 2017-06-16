# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :authenticate_customer!

  def index
    render html: 'Hello!'
  end
end
