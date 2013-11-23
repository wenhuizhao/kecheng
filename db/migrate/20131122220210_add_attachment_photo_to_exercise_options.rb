class AddAttachmentPhotoToExerciseOptions < ActiveRecord::Migration
  def self.up
    change_table :exercise_options do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :exercise_options, :photo
  end
end
