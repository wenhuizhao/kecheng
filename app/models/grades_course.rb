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
  scope :for_user_grade, -> (user, grade) {accepted_courses_of(user).where(period_id: Period.current_period.id, grade_id: grade)}
  before_create :set_default
  
  def name
    full_name
  end

  def set_default
    self.period_id = current_period.id
    self.is_open = true
  end

  def period_name
    "#{period.desc}学期"
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

  def course_homeworks
    homeworks.where(grades_course_id: self.id)
  end
  
  def finished_homeworks
    course_homeworks.where(status: '1')
  end

  def unfinished_homeworks
    course_homeworks.where(status: nil)
  end
  
  def pcourse(desc)
    period_id = Period.where(desc: desc, start_year: period.start_year, end_year: period.end_year).last.try(:id)
    GradesCourse.where(grade_id: grade_id, course_id: course_id, period_id: period_id).last
  end
 
  class << self
    def teacher_for(grade_id, course_id, period_id = Period.current_period.id)
      where(grade_id: grade_id, course_id: course_id, period_id: period_id, is_accept: true)
    end
    
    def has_teacher_for?(grade_id, course_id)
      teacher_for(grade_id, course_id).size > 0
    end
  end
end
