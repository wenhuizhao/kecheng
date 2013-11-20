class AddColumnForHomework < ActiveRecord::Migration
  def up
    add_column :homeworks, :grades_course_id, :integer
  end

  def down
    remove_column :homeworks, :grades_course_id
  end
end
