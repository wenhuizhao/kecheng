class AddPeriodIdToGradesCourses < ActiveRecord::Migration
  def change
    add_column :grades_courses, :period_id, :integer
    add_index :grades_courses, :period_id
  end
end
