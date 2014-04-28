class AddJyjIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :jyj_id, :integer
  end
end
