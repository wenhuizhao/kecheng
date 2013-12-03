# -*- encoding : utf-8 -*-
class Lesson < ActiveRecord::Base
  attr_accessible :grades_course_id, :end_time, :note, :start_time, :teacher_id
  
  has_many :homeworks
  belongs_to :grades_course
  
  def title
    "第#{num}课"
  end
  
  def questions
    Exercise.limit(12)
  end

  def students
    self.grades_course.students
  end
end
