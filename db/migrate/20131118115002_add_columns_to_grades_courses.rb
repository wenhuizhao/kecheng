# -*- encoding : utf-8 -*-
class AddColumnsToGradesCourses < ActiveRecord::Migration
  def change
    add_column :grades_courses, :lesson_num, :string
    add_column :grades_courses, :teacher_id, :integer
  end
end
