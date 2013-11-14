class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :title
      t.string :note
      t.string :answer

      t.timestamps
    end
  end
end
