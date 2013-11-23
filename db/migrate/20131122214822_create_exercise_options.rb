class CreateExerciseOptions < ActiveRecord::Migration
  def change
    create_table :exercise_options do |t|
      t.string :name
      t.integer :exercise_id

      t.timestamps
    end
  end
end
