class CreateExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :exercises, id: :uuid do |t|
      t.string :name, :null => false
      t.references :muscle_group, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :exercises, :name, unique: true
  end
end
