# frozen_string_literal: true

class EndpointAuthorization
  PERMISSIONS = {
    %i[passwords create] => '*',
    %i[passwords edit] => '*',
    %i[passwords update] => '*',
    %i[registrations create] => '*',
    %i[registrations update] => '*',
    %i[registrations destroy] => '*',
    %i[sessions new] => '*',
    %i[sessions create] => '*',
    %i[sessions destroy] => '*',
    %i[application index] => '*',
    %i[token_validations validate_token] => '*',
    %i[users index] => [:client_admin],
    %i[users show] => [:client_admin]
  }.freeze

  def self.authorize!(controller_name, action_name, current_user)
    permission = [PERMISSIONS[[controller_name.to_sym, action_name.to_sym]]].flatten
    return if permission == '*' || permission.first == '*'

    is_authorized = (permission & current_user.roles.map(&:to_sym)).any?

    forbidden_error!(controller_name, action_name, current_user) unless is_authorized
  end

  def self.forbidden_error!(controller_name, action_name, current_user)
    message = I18n.t(
      'authorization.forbidden',
      first_name: current_user.first_name,
      roles: current_user.roles,
      action: "#{controller_name}/#{action_name}"
    )

    Rails.logger.warn message
    raise Exceptions::ForbiddenError, message
  end
end
