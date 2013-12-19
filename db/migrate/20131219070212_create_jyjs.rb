class CreateJyjs < ActiveRecord::Migration
  def change
    create_table :jyjs do |t|
      t.string :name
      t.string :post_code
      t.string :address

      t.timestamps
    end
  end
end
