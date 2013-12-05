class AddNumberToSections < ActiveRecord::Migration
  def change
    add_column :sections, :number, :string
  end
end
