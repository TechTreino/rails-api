# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, if: :should_authenticate_user?
  before_action :set_paper_trail_whodunnit
  before_action :set_current_user
  before_action :authorize!

  rescue_from ActiveRecord::RecordNotFound, with: :response_for_record_not_found
  rescue_from ActionController::RoutingError, with: :response_for_route_not_found
  rescue_from Exceptions::ForbiddenError, with: :response_for_forbidden

  def index
    render plain: 'Techtreino API'
  end

  protected

  def user_for_paper_trail
    current_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password first_name last_name roles])
  end

  def set_current_user
    RequestStore.store[:current_user] ||= current_user
  end

  def response_for_record_not_found(ex)
    render json: { errors: [I18n.t('record_not_found'), ex.message] }, status: :not_found
  end

  def response_for_route_not_found
    render json: { errors: [I18n.t('route_not_found'), ex.message] }, status: :not_found
  end

  def response_for_forbidden(ex)
    render json: { errors: [ex.message] }, status: 403
  end

  def authorize!
    EndpointAuthorization.authorize!(controller_name, action_name, current_user)
  end

  def should_authenticate_user?
    false
  end
end
