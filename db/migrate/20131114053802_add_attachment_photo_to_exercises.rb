class AddAttachmentPhotoToExercises < ActiveRecord::Migration
  def self.up
    change_table :exercises do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :exercises, :photo
  end
end
