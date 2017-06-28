Raven.configure do |config|
  config.environments = %w[production]
  config.excluded_exceptions = ["AbstractController::ActionNotFound", "ActionController::InvalidAuthenticityToken", "ActionController::RoutingError", "ActionController::UnknownAction"]
end
