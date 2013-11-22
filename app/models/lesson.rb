class Lesson < ActiveRecord::Base
  attr_accessible :grades_course_id, :end_time, :note, :start_time, :teacher_id
end
