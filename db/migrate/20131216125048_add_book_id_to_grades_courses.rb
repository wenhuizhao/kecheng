class AddBookIdToGradesCourses < ActiveRecord::Migration
  def change
    add_column :grades_courses, :book_id, :integer
    add_index :grades_courses, :book_id
  end
end
