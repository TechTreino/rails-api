class CreateMuscleGroup < ActiveRecord::Migration[5.1]
  def change
    create_table :muscle_groups, id: :uuid do |t|
      t.string :name
    end
  end
end
