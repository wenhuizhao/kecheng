class AddAttachmentPhotoToFileUploads < ActiveRecord::Migration
  def self.up
    change_table :upload_files do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :upload_files, :photo
  end
end
