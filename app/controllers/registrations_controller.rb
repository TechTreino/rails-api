# frozen_string_literal: true

class RegistrationsController < DeviseTokenAuth::RegistrationsController
  ACCEPTED_SIGN_UP_ROLES = [:customer].freeze

  def create
    if params[:roles].present? && params[:roles].map(&:to_sym) != ACCEPTED_SIGN_UP_ROLES
      message = I18n.t('registrations.roles_not_allowed', roles: ACCEPTED_SIGN_UP_ROLES.join(', '))
      render json: { errors: [message] }, status: :unprocessable_entity
    else
      super do |resource|
        resource.update(params.permit(:first_name, :last_name))
      end
    end
  end
end
