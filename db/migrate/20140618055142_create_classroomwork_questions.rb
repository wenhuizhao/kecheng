class CreateClassroomworkQuestions < ActiveRecord::Migration
  def change
    create_table :classroomwork_questions do |t|
      t.string :content
      t.integer :student_classroomworks_exercise_id
      t.integer :user_id
      t.integer :parent_id

      t.timestamps
    end
#    add_index :classroomwork_questions, :student_classroomworks_exercise_id
    add_index :classroomwork_questions, :user_id
    add_index :classroomwork_questions, :parent_id
  end
end
