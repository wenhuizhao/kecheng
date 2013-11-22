# -*- encoding : utf-8 -*-
class AddCategoryToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :category_id, :int
    add_column :exercises, :book_id, :int
  end
end
