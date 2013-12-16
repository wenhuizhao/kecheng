class AddGradesCourseIdToHomework < ActiveRecord::Migration
  def change
    add_column :homeworks, :grades_course_id, :integer
    add_index :homeworks, :grades_course_id
  end
end
