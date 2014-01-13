class ChangeExtraToLongTextExercise < ActiveRecord::Migration
  def up
    change_column :exercises, :extra, :longtext
  end

  def down
    change_column :exercises, :extra, :text
  end
end
