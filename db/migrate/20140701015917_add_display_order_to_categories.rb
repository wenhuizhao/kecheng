class AddDisplayOrderToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :display_order, :integer
  end
end
