class AddExerciseTextIdToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :exercise_text_id, :integer
  end
end
