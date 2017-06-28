# frozen_string_literal: true

class EndpointAuthorization
  PERMISSIONS = {
    %i[confirmations show] => '*',
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
    %i[users index] => %w[system_admin client_admin],
    %i[users customers] => %w[system_admin client_admin],
    %i[users show] => %w[system_admin client_admin],
    %i[users create] => %w[system_admin client_admin],
    %i[exercises index] => %w[system_admin client_admin customer],
    %i[exercises show] => %w[system_admin client_admin customer],
    %i[exercises create] => %w[system_admin client_admin],
    %i[exercises update] => %w[system_admin client_admin],
    %i[exercises destroy] => %w[system_admin client_admin],
    %i[muscle_groups index] => %w[system_admin client_admin customer],
    %i[workouts index] => %w[system_admin client_admin customer],
    %i[workouts show] => %w[system_admin client_admin customer],
    %i[workouts create] => %w[system_admin client_admin],
    %i[workouts update] => %w[system_admin client_admin],
    %i[workouts destroy] => %w[system_admin client_admin]
  }.freeze

  def self.authorize!(controller_name, action_name, current_user)
    permission = [PERMISSIONS[[controller_name.to_sym, action_name.to_sym]]].flatten
    return if permission == '*' || permission.first == '*'

    is_authorized = (permission & current_user.roles.map(&:name)).any?

    forbidden_error!(controller_name, action_name, current_user) unless is_authorized
  end

  def self.forbidden_error!(controller_name, action_name, current_user)
    message = I18n.t(
      'authorization.forbidden',
      first_name: current_user.first_name,
      roles: current_user.roles.map(&:name),
      action: "#{controller_name}/#{action_name}"
    )

    Rails.logger.warn message
    raise Exceptions::ForbiddenError, message
  end
end
