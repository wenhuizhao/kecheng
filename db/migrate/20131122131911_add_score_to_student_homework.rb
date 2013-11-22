# -*- encoding : utf-8 -*-
class AddScoreToStudentHomework < ActiveRecord::Migration
  def change
    add_column :student_homeworks, :score, :string
    add_column :student_homeworks, :level, :string
    add_column :student_homeworks, :ask_note, :string
  end
end
