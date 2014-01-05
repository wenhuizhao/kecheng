class ChangeNameInExerciseOptions < ActiveRecord::Migration
  def up
    change_column :exercise_options, :name, :text
  end

  def down
    change_column :exercise_options, :name, :string
  end
end
