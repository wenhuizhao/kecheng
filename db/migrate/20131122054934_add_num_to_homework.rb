# -*- encoding : utf-8 -*-
class AddNumToHomework < ActiveRecord::Migration
  def change
    add_column :homeworks, :num, :integer
  end
end
