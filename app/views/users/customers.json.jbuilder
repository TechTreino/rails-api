# frozen_string_literal: true

json.users do
  json.partial! 'users/user', collection: @view.customers, as: :user
end
