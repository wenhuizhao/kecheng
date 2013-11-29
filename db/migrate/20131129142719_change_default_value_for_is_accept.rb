class ChangeDefaultValueForIsAccept < ActiveRecord::Migration
  def up
    change_column :messages, :is_accept, :boolean, default: nil
    change_column :grade_students, :is_accept, :boolean, default: nil
    change_column :grades_courses, :is_accept, :boolean, default: nil
  end

  def down
    change_column :messages, :is_accept, :boolean, default: false
    change_column :grade_students, :is_accept, :boolean, default: false
    change_column :grades_courses, :is_accept, :boolean, default: false
  end
end
