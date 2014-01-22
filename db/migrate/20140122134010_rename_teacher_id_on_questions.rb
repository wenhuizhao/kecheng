class RenameTeacherIdOnQuestions < ActiveRecord::Migration
  def up
    rename_column :questions, :teacher_id, :user_id
    add_index :questions, :user_id
  end
end
