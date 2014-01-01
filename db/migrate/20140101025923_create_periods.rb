class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.string :full_name
      t.string :start_year
      t.string :end_year
      t.string :desc
      t.boolean :is_current

      t.timestamps
    end
  end
end
