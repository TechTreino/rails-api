class CreateMuscleGroup < ActiveRecord::Migration[5.1]
  def change
    create_table :muscle_groups, id: :uuid do |t|
      t.string :name, :null => false

      t.timestamps
    end

    add_index :muscle_groups, :name, unique: true
  end
end
