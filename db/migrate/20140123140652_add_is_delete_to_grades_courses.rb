class AddIsDeleteToGradesCourses < ActiveRecord::Migration
  def change
    add_column :grades_courses, :is_delete, :boolean, default: false 
  end
end
