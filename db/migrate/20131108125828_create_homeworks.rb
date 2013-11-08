class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.integer :course_id
      t.datatime :end_time

      t.timestamps
    end
  end
end
