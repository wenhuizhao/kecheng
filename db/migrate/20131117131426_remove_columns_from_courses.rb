# -*- encoding : utf-8 -*-
class RemoveColumnsFromCourses < ActiveRecord::Migration
  def up
    remove_column :courses, :stu_class_id
    remove_column :courses, :is_open
  end

  def down
    add_column :courses, :stu_class_id, :integer
    add_column :courses, :is_open, :integer
  end
end
