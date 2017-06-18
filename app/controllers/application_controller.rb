# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_paper_trail_whodunnit
  before_action :set_current_customer
  rescue_from ActiveRecord::RecordNotFound, with: :response_for_record_not_found
  rescue_from ActionController::RoutingError, with: :response_for_route_not_found

  def user_for_paper_trail
    current_customer
  end

  def set_current_customer
    RequestStore.store[:current_customer] ||= current_customer
  end

  def response_for_record_not_found(ex)
    render json: { errors: [I18n.t('record_not_found'), ex.message] }, status: :not_found
  end

  def response_for_route_not_found
    render json: { errors: [I18n.t('route_not_found'), ex.message] }, status: :not_found
  end

  def index
    render plain: 'Techtreino API'
  end
end
