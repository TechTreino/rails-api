# frozen_string_literal: true

# Used to only find records for the current user's client_id
module ScopedToClient
  extend ActiveSupport::Concern

  included do
    scope :by_client, -> { where(client_id: RequestStore.store[:current_user].client_id) }
  end
end
