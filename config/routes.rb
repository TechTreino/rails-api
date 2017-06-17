# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'Customer', at: 'auth', controllers: {
    confirmations:      'devise_token_auth/confirmations',
    passwords:          'devise_token_auth/passwords',
    omniauth_callbacks: 'devise_token_auth/omniauth_callbacks',
    registrations:      'registrations',
    sessions:           'devise_token_auth/sessions',
    token_validations:  'devise_token_auth/token_validations'
  }

  root to: 'application#index'

  resources :customers, only: %i[index show]
end
