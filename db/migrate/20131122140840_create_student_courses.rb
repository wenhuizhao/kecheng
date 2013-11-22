# -*- encoding : utf-8 -*-
class CreateStudentCourses < ActiveRecord::Migration
  def change
    create_table :student_courses do |t|
      t.integer :grades_course_id
      t.integer :student_id
      t.string :note
      t.string :score

      t.timestamps
    end

    add_index :student_courses, :student_id
    add_index :student_courses, :grades_course_id
  end
end
