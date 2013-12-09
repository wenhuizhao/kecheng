class ExerciseText < ActiveRecord::Base
  attr_accessible :book_id, :title, :content, :page, :section_id, :photo
  has_attached_file :photo
  belongs_to :book
  belongs_to :section
  has_many :exercises
end
