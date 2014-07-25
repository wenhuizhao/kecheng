class AddLessonNumToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :lesson_num, :integer
  end
end
