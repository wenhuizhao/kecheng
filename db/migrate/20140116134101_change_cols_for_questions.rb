class ChangeColsForQuestions < ActiveRecord::Migration
  def change
    rename_column :questions, :title, :content 
    add_column :questions, :student_homeworks_exercise_id, :integer 
    add_column :questions, :teacher_id, :integer 
    add_column :questions, :parent_id, :integer 
    remove_column :questions, :homework_id
    add_index :questions, :student_homeworks_exercise_id 
    add_index :questions, :teacher_id 
    add_index :questions, :parent_id
  end
end
