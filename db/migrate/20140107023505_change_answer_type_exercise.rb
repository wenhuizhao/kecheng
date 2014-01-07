class ChangeAnswerTypeExercise < ActiveRecord::Migration
  def up
    change_column :exercises, :answer, :text
  end

  def down
    change_column :exercises, :answer, :sring
  end
end
