# -*- encoding : utf-8 -*-
class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.integer :course_id
      t.datetime :end_time

      t.timestamps
    end
  end
end
