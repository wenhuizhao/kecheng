class CreateUploadFiles < ActiveRecord::Migration
  def change
    create_table :upload_files do |t|
      t.string :name
      t.integer :exercise_id

      t.timestamps
    end
  end
end
