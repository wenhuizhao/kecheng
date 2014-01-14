class AddAnswerToStudentHomeworksExercises < ActiveRecord::Migration
  def change
    add_column :student_homeworks_exercises, :answer, :text
    add_index :student_homeworks_exercises, :student_homework_id
    add_index :student_homeworks_exercises, :exercise_id
  end
end
