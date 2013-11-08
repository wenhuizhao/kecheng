class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :desc
      t.boolean :is_open
      t.integer :stu_class_id

      t.timestamps
    end
  end
end
