class AddExtraToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :extra, :text
  end
end
