class AddIdsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :school_id, :integer
    add_column :messages, :course_id, :integer
    add_column :grades_courses, :is_accept, :boolean
    
    add_index :messages, :school_id
    add_index :messages, :course_id
  end
end
