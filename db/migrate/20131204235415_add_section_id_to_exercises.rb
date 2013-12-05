class AddSectionIdToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :section_id, :integer
  end
end
