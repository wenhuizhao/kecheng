class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :grade_num
      t.integer :class_num
      t.string :full_name
      t.string :period

      t.timestamps
    end
  end
end
