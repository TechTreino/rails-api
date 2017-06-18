# frozen_string_literal: true

# Used to only find records for the current customer's client_id
module ScopedToClient
  extend ActiveSupport::Concern

  included do
    scope :by_client, -> { where(client: RequestStore.store[:current_customer].client) }
  end
end
