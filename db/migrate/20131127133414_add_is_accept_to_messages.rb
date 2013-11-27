class AddIsAcceptToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :is_accept, :boolean, default: false
  end
end
