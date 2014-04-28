# -*- encoding : utf-8 -*-
class School < ActiveRecord::Base
  attr_accessible :name, :post_code, :address, :jyj_id
  has_many :users
  has_many :grades_courses, through: :grades
  has_many :grades
  has_many :homeworks, through: :grades
  belongs_to :jyj
  validates :name, presence: true
  scope :for_user, -> (user) { user.is_admin? ? all : where(id: user.school_id) }
  
  include Mgrade::Homeworks
  
  def grades_range
    #Grade.select('grade_num').collect(&:grade_num).uniq
    (1..6).to_a
  end

  def classes_range
    # Grade.select('class_num').collect(&:class_num).uniq
    (1..50).to_a
  end

  def teachers
    users.where(role_id: 3)
    # User.teachers_of(self)
  end

  def students
    users.where(role_id: 2)
  end

  def grade_course_ids
    grades_courses.where(is_accept: true).map {|gs| [gs.grade.try(:grade_num), gs.course_id]}.sort_by{|a| a[0]}.uniq
    # grades_courses.group('course_id').select('course_id, grade_id').map{|g| [g.grade_id, g.course_id]}.sort_by(&:first)
  end
  
  def grade_courses(ids = grade_course_ids)
    GradeCourse.builds(ids)
  end

end
