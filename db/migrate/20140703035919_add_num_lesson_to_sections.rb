class AddNumLessonToSections < ActiveRecord::Migration
  def change
    add_column :sections, :num_lessons, :integer
  end
end
