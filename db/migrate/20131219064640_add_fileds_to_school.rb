class AddFiledsToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :post_code, :string
    add_column :schools, :address, :string
    add_column :schools, :jyj_id, :integer
    add_index :schools, :jyj_id
  end
end
