# frozen_string_literal: true

json.user do
  json.partial! 'users/user', user: @view.user
end
