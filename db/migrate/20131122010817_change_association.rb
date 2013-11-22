# -*- encoding : utf-8 -*-
class ChangeAssociation < ActiveRecord::Migration
  def up
    remove_column :homeworks, :grades_course_id
    rename_column :lessons, :course_id, :grades_course_id
  end

  def down
    add_column :homeworks, :grades_course_id
    rename_column :lessons, :grades_course_id, :course_id
  end
end
