class ChangeTitleTypeInExercise < ActiveRecord::Migration
  def up
    change_column :exercises, :title, :text
  end

  def down
    change_column :exercises, :title, :string
  end
end
