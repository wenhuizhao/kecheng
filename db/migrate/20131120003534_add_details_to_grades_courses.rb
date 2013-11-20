class AddDetailsToGradesCourses < ActiveRecord::Migration
  def change
    add_column :grades_courses, :outline, :text
  end
end
