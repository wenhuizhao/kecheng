class ChangeNoteTypeInExercise < ActiveRecord::Migration
  def up
    change_column :exercises, :note, :text
  end

  def down
    change_column :exercises, :note, :string
  end
end
