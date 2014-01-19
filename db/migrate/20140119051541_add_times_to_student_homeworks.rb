class AddTimesToStudentHomeworks < ActiveRecord::Migration
  def change
    add_column :student_homeworks, :times, :integer, default: 1 
  end
end
