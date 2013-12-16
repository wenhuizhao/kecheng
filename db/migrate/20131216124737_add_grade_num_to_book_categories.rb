class AddGradeNumToBookCategories < ActiveRecord::Migration
  def change
    add_column :book_categories, :grade_num, :integer
  end
end
