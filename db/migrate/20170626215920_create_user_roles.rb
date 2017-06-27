class CreateUserRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_roles, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid
      t.references :role, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
