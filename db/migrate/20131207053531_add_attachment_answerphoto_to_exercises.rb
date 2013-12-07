class AddAttachmentAnswerphotoToExercises < ActiveRecord::Migration
  def self.up
    change_table :exercises do |t|
      t.attachment :answerphoto
    end
  end

  def self.down
    drop_attached_file :exercises, :answerphoto
  end
end
