class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.integer :parent_id
      t.integer :book_id

      t.timestamps
    end
  end
end
