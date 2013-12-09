class AddSectionIdToExerciseTexts < ActiveRecord::Migration
  def change
    add_column :exercise_texts, :section_id, :integer
  end
end
