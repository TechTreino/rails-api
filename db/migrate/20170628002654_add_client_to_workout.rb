class AddClientToWorkout < ActiveRecord::Migration[5.1]
  def change
    add_reference :workouts, :client, foreign_key: true, type: :uuid
  end
end
