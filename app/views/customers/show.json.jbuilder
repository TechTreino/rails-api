# frozen_string_literal: true

json.customer do
  json.partial! 'customers/customer', customer: @view.customer
end
