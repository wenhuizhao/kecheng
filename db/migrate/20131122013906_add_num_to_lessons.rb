# -*- encoding : utf-8 -*-
class AddNumToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :num, :integer
  end
end
