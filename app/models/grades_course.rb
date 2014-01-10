# -*- encoding : utf-8 -*-
class GradesCourse < ActiveRecord::Base
  attr_accessible :course_id, :grade_id, :book_id, :is_open, :teacher_id, :lesson_num, :outline, :is_accept, :period_id

  include Mgrade, Common
  include Grade::Name
  include Mgrade::Homeworks

  belongs_to :course
  belongs_to :teacher, class_name: 'User'
  belongs_to :grade
  belongs_to :book
  belongs_to :period

  has_many :lessons
  has_many :student_courses
  has_many :homeworks
  # has_many :students, through: :student_courses

  validates :grade_id, :course_id, :book_id, presence: true
  
  # validates :course_id, uniqueness: {scope: :grade_id}
  # validates :book_id, uniqueness: {scope: :course_id}
  
  scope :all_courses_of, -> (user) {where(teacher_id: user.id)}
  scope :opened, -> {where(is_open: true)}
  scope :for_select, -> (grade) {opened.where(grade_id: grade.id, is_accept: true)}
  scope :accepted_courses_of, -> (user) {all_courses_of(user).where(is_accept: true)}
  before_create :set_default
  
  def name
    full_name
  end

  def set_default
    self.period_id = current_period.id
    self.is_open = true
  end

  def course_name
    course.try :name
  end
  
  def status
    return '待审批' unless is_accept
    is_open ? '已开放' : '拒绝开课'
  end

  def teacher_name
    teacher.try :name
  end
  
  def full_name
    grades ? grades + self.course_name : ''
  end
  
  def students
    grade.try :students
  end

  def sections
    book.sections
  end
end
