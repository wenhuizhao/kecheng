class AddTitleToExerciseText < ActiveRecord::Migration
  def change
    add_column :exercise_texts, :title, :string
  end
end
