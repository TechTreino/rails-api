class CreateExercisesMuscleGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :exercises_muscle_groups, id: :uuid do |t|
      t.references :exercise, foreign_key: true, type: :uuid
      t.references :muscle_group, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
