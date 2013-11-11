class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :teacher_id
      t.integer :course_id
      t.string  :note
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
