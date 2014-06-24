class CreateClassroomWorks < ActiveRecord::Migration
  def change
    create_table :classroomworks do |t|
      t.integer :course_id
      t.datetime :end_time
      t.string :enjoin
      t.integer :lesson_id
      t.integer :book_id
      t.integer :num
      t.string :status
      t.integer :section_id
      t.integer :grades_course_id

      t.timestamps
    end
    add_index :classroomworks, :section_id
    add_index :classroomworks, :grades_course_id
  end
end
