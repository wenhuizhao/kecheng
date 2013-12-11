class AddBgNumToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bg_num, :string, default: 0
  end
end
