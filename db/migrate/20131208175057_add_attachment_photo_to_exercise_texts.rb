class AddAttachmentPhotoToExerciseTexts < ActiveRecord::Migration
  def self.up
    change_table :exercise_texts do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :exercise_texts, :photo
  end
end
