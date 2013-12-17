class AddNumToSections < ActiveRecord::Migration
  def change
    add_column :sections, :num, :integer
  end
end
