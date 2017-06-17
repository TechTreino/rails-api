# frozen_string_literal: true

json.customers do
  json.partial! 'customers/customer', collection: @view.customers, as: :customer
end
