# -*- encoding : utf-8 -*-
class GradesCourse < ActiveRecord::Base
  attr_accessible :course_id, :grade_id, :is_open, :teacher_id, :lesson_num, :outline

  include Mgrade

  belongs_to :course
  belongs_to :teacher, class_name: 'User'
  belongs_to :grade

  has_many :lessons
  has_many :student_courses
  has_many :students, through: :student_courses

  validates :grade_id, :course_id, :outline, presence: true
  
  def course_name
    course.try :name
  end
  
  def status
    is_open ? '已开放' : '关闭'
  end

  def teacher_name
    teacher.try :name
  end
  
  def grades
    App::ChineseNum[self.grade_num.to_i] + '年级' + App::ChineseNum[self.class_num.to_i] + "班" if self.grade_num
  end
  
  def full_name
    grades ? grades + self.course_name : ''
  end
end
