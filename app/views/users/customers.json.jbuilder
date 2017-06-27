# frozen_string_literal: true

json.customers do
  json.partial! 'users/user', collection: @view.customers, as: :user
end
