class CreateStudentHomeworksExercises < ActiveRecord::Migration
  def change
    create_table :student_homeworks_exercises do |t|
      t.integer :student_homework_id
      t.integer :exercise_id
      t.text :canvas

      t.timestamps
    end
  end
end
