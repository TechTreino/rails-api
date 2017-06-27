# frozen_string_literal: true

class SessionsController < DeviseTokenAuth::SessionsController
  ACCEPTED_SIGN_IN_ROLES = %w[system_admin client_admin customer].freeze

  def create
    if valid_roles_params?
      sign_in_user
    else
      translated_roles = ACCEPTED_SIGN_IN_ROLES.map { |role| I18n.t("roles.#{role}") }
      message = I18n.t('sessions.roles_not_allowed', roles: translated_roles.join(', '))

      render json: { errors: [message] }, status: :unprocessable_entity
    end
  end

  protected

  def valid_roles_params?
    params[:roles].present? && (params[:roles] & ACCEPTED_SIGN_IN_ROLES).any?
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  # Method extracted from DeviseTokenAuth::SessionsController
  def sign_in_user
    initialize_resource_params

    if @resource &&
       valid_params?(@resource_field, @resource_query_value) &&
       roles_are_accepted?(@resource) &&
       (!@resource.respond_to?(:active_for_authentication?) || @resource.active_for_authentication?)
      valid_password = @resource.valid_password?(resource_params[:password])

      if valid_for_auth(valid_password) || !valid_password
        render_create_error_bad_credentials

        return
      end

      # create client id
      @client_id = SecureRandom.urlsafe_base64(nil, false)
      @token     = SecureRandom.urlsafe_base64(nil, false)

      @resource.tokens[@client_id] = {
        token: BCrypt::Password.create(@token),
        expiry: (Time.now.utc + DeviseTokenAuth.token_lifespan).to_i
      }
      @resource.save

      sign_in(:user, @resource, store: false, bypass: false)

      yield @resource if block_given?

      render_create_success
    elsif @resource && !roles_are_accepted?(@resource)
      render_user_role_not_allowed
    elsif @resource && !(!@resource.respond_to?(:active_for_authentication?) || @resource.active_for_authentication?)
      render_create_error_not_confirmed
    else
      render_create_error_bad_credentials
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  def initialize_resource_params
    @resource_field = (resource_params.keys.map(&:to_sym) & resource_class.authentication_keys).first
    @resource = nil

    return unless @resource_field

    @resource_query_value = resource_params[@resource_field]
    @resource_query_value.downcase! if resource_class.case_insensitive_keys.include?(@resource_field)
    query = "#{@resource_field} = ? AND provider='email'"

    @resource = resource_class.where(query, @resource_query_value).first
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def valid_for_auth(valid_password)
    @resource.respond_to?(:valid_for_authentication?) && !@resource.valid_for_authentication? { valid_password }
  end

  def roles_are_accepted?(resource)
    resource.roles.any? do |role|
      role == Role.system_admin || params[:roles].include?(role.name)
    end
  end

  def render_user_role_not_allowed
    message = I18n.t('sessions.user_role_not_allowed')

    render json: { errors: [message] }, status: :unprocessable_entity
  end
end
