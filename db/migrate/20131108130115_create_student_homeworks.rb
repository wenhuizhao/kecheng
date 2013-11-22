# -*- encoding : utf-8 -*-
class CreateStudentHomeworks < ActiveRecord::Migration
  def change
    create_table :student_homeworks do |t|
      t.integer :student_id
      t.integer :homework_id
      t.string :status

      t.timestamps
    end
  end
end
