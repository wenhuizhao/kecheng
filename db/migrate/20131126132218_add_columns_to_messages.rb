class AddColumnsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :is_open, :boolean, default: false
    add_column :messages, :parent_id, :integer
    add_column :messages, :type_name, :string
    add_index :messages, :parent_id
  end
end
