class CreateStuGradeCourses < ActiveRecord::Migration
  def change
    create_table :stu_grade_courses do |t|
      t.string :score
      t.string :note

      t.timestamps
    end
  end
end
