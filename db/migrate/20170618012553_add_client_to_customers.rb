class AddClientToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :client, foreign_key: true, type: :uuid
  end
end
