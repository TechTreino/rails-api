# frozen_string_literal: true

json.users do
  json.partial! 'users/user', collection: @view.users, as: :user
end
