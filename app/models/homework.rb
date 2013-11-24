# -*- encoding : utf-8 -*-
class Homework < ActiveRecord::Base
  attr_accessible :lesson_id, :end_time, :enjoin, :book_id, :exercise_ids, :num
  belongs_to :book
  belongs_to :lesson

  has_and_belongs_to_many :exercises
  
  has_many :student_homeworks
  has_many :students, through: :student_homeworks

  validates :enjoin, presence: true

  def unsubmit_students
    self.lesson.students - self.students
  end

  def grades_course
    lesson.try :grades_course
  end
end
