class AddSchoolIdToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :school_id, :integer
    add_index :grades, :school_id
  end
end
