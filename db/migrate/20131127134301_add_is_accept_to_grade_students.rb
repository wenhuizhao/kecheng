class AddIsAcceptToGradeStudents < ActiveRecord::Migration
  def change
    add_column :grade_students, :is_accept, :boolean, default: false
  end
end
