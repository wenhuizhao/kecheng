class Homework < ActiveRecord::Base
  attr_accessible :lesson_id, :end_time, :enjoin, :book_id, :exercise_ids, :num
  belongs_to :book
  belongs_to :lesson
  has_and_belongs_to_many :exercises
  
  validates :enjoin, presence: true
end
