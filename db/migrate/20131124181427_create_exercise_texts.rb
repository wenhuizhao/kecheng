class CreateExerciseTexts < ActiveRecord::Migration
  def change
    create_table :exercise_texts do |t|
      t.text :content
      t.integer :book_id
      t.string :section
      t.integer :page

      t.timestamps
    end
  end
end
