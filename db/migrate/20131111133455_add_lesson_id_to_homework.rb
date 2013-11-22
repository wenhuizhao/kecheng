# -*- encoding : utf-8 -*-
class AddLessonIdToHomework < ActiveRecord::Migration
  def change
    add_column :homeworks, :lession_id, :integer
    remove_column :homeworks, :course_id
  end
end
