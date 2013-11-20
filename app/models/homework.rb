class Homework < ActiveRecord::Base
  attr_accessible :grades_course_id, :end_time
  belongs_to :grades_course
end
