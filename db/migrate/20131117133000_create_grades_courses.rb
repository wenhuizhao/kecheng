class CreateGradesCourses < ActiveRecord::Migration
  def change
    create_table :grades_courses do |t|
      t.integer :grade_num
      t.string :class_num
      t.integer :course_id
      t.boolean :is_open

      t.timestamps
    end
 
    add_index :grades_courses, :course_id
    add_index :grades_courses, :grade_num
    add_index :grades_courses, :class_num
  end
end
