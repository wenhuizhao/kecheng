# -*- encoding : utf-8 -*-
class GradesCourse < ActiveRecord::Base
  attr_accessible :course_id, :grade_id, :book_id, :is_open, :teacher_id, :lesson_num, :outline, :is_accept

  include Mgrade
  include Grade::Name

  belongs_to :course
  belongs_to :teacher, class_name: 'User'
  belongs_to :grade
  belongs_to :book

  has_many :lessons
  has_many :student_courses
  has_many :students, through: :student_courses

  validates :grade_id, :course_id, :book_id, presence: true
  
  validates :course_id, uniqueness: {scope: :grade_id}
  # validates :book_id, uniqueness: {scope: :course_id}
  
  scope :all_courses_of, -> (user) {where(teacher_id: user.id)}
  scope :opened, -> {where(is_open: true)}
  scope :for_select, -> (grade) {opened.where(grade_id: grade.id, is_accept: true)}
  scope :accepted_courses_of, -> (user) {all_courses_of(user).where(is_accept: true)}

  def course_name
    course.try :name
  end
  
  def status
    return '待上级批准' unless is_accept
    is_open ? '已开放' : '关闭'
  end

  def teacher_name
    teacher.try :name
  end
  
  def full_name
    grades ? grades + self.course_name : ''
  end

  def sections
    book.sections
  end
end
