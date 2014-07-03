class CreateSectionLessonCategories < ActiveRecord::Migration
  def change
    create_table :section_lesson_categories do |t|
      t.integer :section_id
      t.integer :lesson
      t.integer :category_id

      t.timestamps
    end
    add_index :section_lesson_categories, [:section_id, :lesson]
    add_index :section_lesson_categories, :category_id
  end

end
