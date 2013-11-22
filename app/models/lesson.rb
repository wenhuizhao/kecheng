class Lesson < ActiveRecord::Base
  attr_accessible :grades_course_id, :end_time, :note, :start_time, :teacher_id
  
  has_many :homeworks
  belongs_to :grades_course
  
  def title
    "第#{num}课"
  end
end
