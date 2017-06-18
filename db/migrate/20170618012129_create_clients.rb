class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients, id: :uuid do |t|
      t.string :name
      t.string :address
      t.string :cnpj
      t.string :email

      t.timestamps
    end
  end
end
