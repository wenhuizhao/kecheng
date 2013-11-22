# -*- encoding : utf-8 -*-
class CreateGradeStudents < ActiveRecord::Migration
  def change
    create_table :grade_students do |t|
      t.integer :grade_num
      t.integer :class_num
      t.integer :student_id

      t.timestamps
    end
    add_index :grade_students, :student_id
    add_index :grade_students, :grade_num
    add_index :grade_students, :class_num
  end
end
