# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'Customer', at: 'auth'

  root to: 'application#index'

  resources :customers, only: %i[index show]
end
