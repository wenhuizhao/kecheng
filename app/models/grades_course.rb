class GradesCourse < ActiveRecord::Base
  attr_accessible :class_num, :course_id, :grade_num, :is_open, :teacher_id, :lesson_num

  belongs_to :course
  belongs_to :teacher, class_name: 'User'

  validates :class_num, :grade_num, :course_id, presence: true
  
  def course_name
    course ? course.name : ''
  end

  def teacher_name
    teacher ? teacher.name : ''
  end
end
