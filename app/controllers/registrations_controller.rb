# frozen_string_literal: true

class RegistrationsController < DeviseTokenAuth::RegistrationsController
  ACCEPTED_SIGN_UP_ROLES = ['customer'].freeze

  # rubocop:disable all
  # Method extracted from DeviseTokenAuth::RegistrationsController
  def create
    if params[:roles].present? && params[:roles] != ACCEPTED_SIGN_UP_ROLES
      translated_roles = ACCEPTED_SIGN_UP_ROLES.map { |role| I18n.t("roles.#{role}") }
      message = I18n.t('registrations.roles_not_allowed', roles: translated_roles.join(', '))

      return render json: { errors: [message] }, status: :unprocessable_entity
    end

    @resource = resource_class.new(sign_up_params)
    @resource.provider = 'email'
    @resource.client = Client.find(params[:client_id]) if params[:client_id]
    @resource.client = Client.find_by!(slug: params[:client_slug]) if params[:client_slug]

    # honor devise configuration for case_insensitive_keys
    @resource.email = if resource_class.case_insensitive_keys.include?(:email)
                        sign_up_params[:email].try(:downcase)
                      else
                        sign_up_params[:email]
                      end

    # give redirect value from params priority
    @redirect_url = params[:confirm_success_url]

    # fall back to default value if provided
    @redirect_url ||= DeviseTokenAuth.default_confirm_success_url

    # success redirect url is required
    if resource_class.devise_modules.include?(:confirmable) && !@redirect_url
      return render_create_error_missing_confirm_success_url
    end

    # if whitelist is set, validate redirect_url against whitelist
    if DeviseTokenAuth.redirect_whitelist
      unless DeviseTokenAuth::Url.whitelisted?(@redirect_url)
        return render_create_error_redirect_url_not_allowed
      end
    end

    begin
      # override email confirmation, must be sent manually from ctrl
      resource_class.set_callback('create', :after, :send_on_create_confirmation_instructions)
      resource_class.skip_callback('create', :after, :send_on_create_confirmation_instructions)
      if @resource.save
        yield @resource if block_given?

        if @resource.confirmed?
          # email auth has been bypassed, authenticate user
          @client_id = SecureRandom.urlsafe_base64(nil, false)
          @token     = SecureRandom.urlsafe_base64(nil, false)

          @resource.tokens[@client_id] = {
            token: BCrypt::Password.create(@token),
            expiry: (Time.now.utc + DeviseTokenAuth.token_lifespan).to_i
          }

          @resource.save!

          update_auth_header
        else
          # user will require email authentication
          @resource.send_confirmation_instructions({
            client_config: params[:config_name],
            redirect_url: @redirect_url
          })
        end

        render_create_success
      else
        clean_up_passwords @resource
        render_create_error
      end
    rescue ActiveRecord::RecordNotUnique
      clean_up_passwords @resource
      render_create_error_email_already_exists
    end
  end
  # rubocop:enable all
end
