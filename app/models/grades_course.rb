# -*- encoding : utf-8 -*-
class GradesCourse < ActiveRecord::Base
  attr_accessible :class_num, :course_id, :grade_num, :is_open, :teacher_id, :lesson_num, :outline

  belongs_to :course
  belongs_to :teacher, class_name: 'User'
  has_many :lessons
  has_many :student_courses
  has_many :students, through: :student_courses

  validates :class_num, :grade_num, :course_id, :outline, presence: true
  
  def course_name
    course ? course.name : ''
  end
  
  def status
    is_open ? '已开放' : '关闭'
  end

  def teacher_name
    teacher ? teacher.name : ''
  end
  
  def grades
    App::ChineseNum[self.grade_num.to_i] + '年级' + App::ChineseNum[self.class_num.to_i] + "班" if self.grade_num
  end
  
  def full_name
    grades ? grades + self.course_name : ''
  end
end
