# frozen_string_literal: true

class RegistrationsController < DeviseTokenAuth::RegistrationsController
  ACCEPTED_SIGN_UP_ROLES = [:customer].freeze

  # rubocop:disable Metrics/AbcSize
  def create
    if params[:roles].present? && params[:roles].map(&:to_sym) != ACCEPTED_SIGN_UP_ROLES
      translated_roles = ACCEPTED_SIGN_UP_ROLES.map { |role| I18n.t("roles.#{role}") }
      message = I18n.t('registrations.roles_not_allowed', roles: translated_roles.join(', '))

      render json: { errors: [message] }, status: :unprocessable_entity
    else
      super do |resource|
        resource.update(params.permit(:first_name, :last_name))
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
end
