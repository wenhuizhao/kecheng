class CreateChangeTeacherLogs < ActiveRecord::Migration
  def change
    create_table :change_teacher_logs do |t|
      t.integer :prev_teacher_id
      t.integer :curr_teacher_id
      t.integer :admin_id
      t.integer :grades_course_id

      t.timestamps
    end
    add_index :change_teacher_logs, :prev_teacher_id
    add_index :change_teacher_logs, :curr_teacher_id
    add_index :change_teacher_logs, :admin_id
    add_index :change_teacher_logs, :grades_course_id
  end
end
