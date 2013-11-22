# -*- encoding : utf-8 -*-
class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
  end
end
