class AddColsToStudentHomeworksExercises < ActiveRecord::Migration
  def change
    add_column :student_homeworks_exercises, :teacher_id, :integer
    add_index :student_homeworks_exercises, :teacher_id 
    add_column :student_homeworks_exercises, :check_desc, :string
  end
end
