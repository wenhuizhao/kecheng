class Lesson < ActiveRecord::Base
  attr_accessible :course_id, :end_time, :note, :start_time, :teacher_id
end
