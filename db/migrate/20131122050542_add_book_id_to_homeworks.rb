class AddBookIdToHomeworks < ActiveRecord::Migration
  def change
    add_column :homeworks, :book_id, :integer
  end
end
