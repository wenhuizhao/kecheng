class ChangeCols < ActiveRecord::Migration
  def change
    add_column :messages, :period_id, :integer
    add_column :change_teacher_logs, :new_grades_course_id, :integer
    add_column :change_teacher_logs, :message_id, :integer
    add_index :change_teacher_logs, :message_id
    add_index :change_teacher_logs, :new_grades_course_id
    add_index :messages, :period_id
  end
end
