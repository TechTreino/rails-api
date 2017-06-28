class CreateWorkoutExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :workout_exercises, id: :uuid do |t|
      t.references :workout, foreign_key: true, type: :uuid
      t.references :exercise, foreign_key: true, type: :uuid
      t.integer :sets
      t.integer :repetitions

      t.timestamps
    end
  end
end
