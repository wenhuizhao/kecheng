# -*- encoding : utf-8 -*-
class CreateExercisesHomeworks < ActiveRecord::Migration
  def change
    create_table :exercises_homeworks, id: false do |t|
      t.integer :exercise_id
      t.integer :homework_id
    end
  end
end
