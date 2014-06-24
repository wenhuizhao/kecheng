class CreateExercisesClassroomworks < ActiveRecord::Migration
  def change
    create_table :classroomworks_exercises, id: false do |t|
      t.integer :exercise_id
      t.integer :classroomwork_id
    end
  end
end
