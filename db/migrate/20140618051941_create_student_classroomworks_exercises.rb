class CreateStudentClassroomworksExercises < ActiveRecord::Migration
  def change
    create_table :student_classroomworks_exercises do |t|
      t.integer :student_classroomwork_id
      t.integer :exercise_id
      t.text :canvas
      t.text :answer
      t.integer :teacher_id
      t.string :check_desc

      t.timestamps
    end
    add_index :student_classroomworks_exercises, :student_classroomwork_id
    add_index :student_classroomworks_exercises, :exercise_id
    add_index :student_classroomworks_exercises, :teacher_id
  end
end
