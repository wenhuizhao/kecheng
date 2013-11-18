class GradesCourse < ActiveRecord::Base
  attr_accessible :class_num, :course_id, :grade_num, :is_open

  belongs_to :course
  belongs_to :teacher, class_name: 'User'

  def course_name
    course ? course_name : ''
  end

  def teacher_name
    teacher ? teacher_name : ''
  end
end
