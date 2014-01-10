# -*- encoding : utf-8 -*-
class School < ActiveRecord::Base
  attr_accessible :name, :post_code, :address, :jyj_id
  has_many :users
  has_many :grades_courses, through: :grades
  has_many :grades
  has_many :homeworks, through: :grades
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
    User.teachers_of(self)
  end

  def grade_course_ids
    grades_courses.group('course_id').select('course_id, grade_id').map{|g| [g.grade_id, g.course_id]}.sort_by(&:first)
  end
  
  def grade_courses(ids = grade_course_ids)
    GradeCourse.builds(ids)
  end

end
