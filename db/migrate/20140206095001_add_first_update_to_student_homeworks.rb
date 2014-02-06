class AddFirstUpdateToStudentHomeworks < ActiveRecord::Migration
  def change
    add_column :student_homeworks, :first_update, :datetime
  end
end
