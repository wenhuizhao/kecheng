class AddSectionIdToHomeworks < ActiveRecord::Migration
  def change
    add_column :homeworks, :section_id, :integer
    add_index :homeworks, :section_id
  end
end
