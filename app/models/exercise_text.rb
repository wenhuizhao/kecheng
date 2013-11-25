class ExerciseText < ActiveRecord::Base
  attr_accessible :book_id, :title, :content, :page, :section
  belongs_to :book
  has_many :exercises
end
