class CreateQtypes < ActiveRecord::Migration
  def change
    create_table :qtypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
