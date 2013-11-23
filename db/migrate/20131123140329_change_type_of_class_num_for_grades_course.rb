class ChangeTypeOfClassNumForGradesCourse < ActiveRecord::Migration
  def up
    change_column :grades_courses, :class_num, :integer
  end

  def down
    change_column :grades_courses, :class_num, :string
  end
end
