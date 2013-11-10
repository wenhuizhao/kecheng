class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login, :string
    add_column :users, :gender, :string
    add_column :users, :phone, :string
    add_column :users, :auth_code, :string
    add_column :users, :school_id, :integer
  end
end
