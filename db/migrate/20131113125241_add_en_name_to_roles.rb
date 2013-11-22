# -*- encoding : utf-8 -*-
class AddEnNameToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :en_name, :string
  end
end
