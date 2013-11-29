class ChangeAssoicationGradesRelated < ActiveRecord::Migration
  def up
    remove_column :grade_students, :grade_num
    remove_column :grade_students, :class_num
    add_column :grade_students, :grade_id, :integer 
    
    remove_column :grades_courses, :grade_num
    remove_column :grades_courses, :class_num
    add_column :grades_courses, :grade_id, :integer 
       
    add_column :messages, :grade_id, :integer 
    
    add_index :grade_students, :grade_id
    add_index :grades_courses, :grade_id
    add_index :messages, :grade_id
  end

  def down
  end
end
