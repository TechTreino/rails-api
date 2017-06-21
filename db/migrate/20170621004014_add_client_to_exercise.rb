class AddClientToExercise < ActiveRecord::Migration[5.1]
  def change
    add_reference :exercises, :client, foreign_key: true, type: :uuid
  end
end
