# -*- encoding : utf-8 -*-
class Homework < ActiveRecord::Base
  attr_accessible :grades_course_id, :lesson_id, :end_time, :enjoin, :book_id, :exercise_ids, :num
  belongs_to :book
  belongs_to :lesson
  belongs_to :section
  belongs_to :grades_course

  has_and_belongs_to_many :exercises
  
  has_many :student_homeworks
  has_many :students, through: :student_homeworks

  validates :enjoin, presence: true

  def unsubmit_students
    # self.lesson.students - self.students
    self.grades_course.students - self.students
  end
  
  def of_user(user)
    student_homeworks.select{|sh| sh.student_id == user.id}.last
  end
  
  def short_name
    grades_course.course_name + '第' + section.num.to_s + '课作业' + num.to_s
  end

  def full_name
    grades_course.try(:full_name).to_s + '第' + section.num.to_s + '课作业' + num.to_s
  end

end
