class AddQtypeIdToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :qtype_id, :integer
  end
end
