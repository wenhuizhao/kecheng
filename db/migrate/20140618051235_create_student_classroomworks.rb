class CreateStudentClassroomworks < ActiveRecord::Migration
  def change
    create_table :student_classroomworks do |t|
      t.integer :student_id
      t.integer :classroomwork_id
      t.string :status
      t.string :score
      t.string :level
      t.string :ask_note
      t.integer :times
      t.datetime :first_update

      t.timestamps
    end
  end
end
