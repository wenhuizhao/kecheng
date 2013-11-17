class GradesCourse < ActiveRecord::Base
  attr_accessible :class_num, :course_id, :grade_num, :is_open
end
