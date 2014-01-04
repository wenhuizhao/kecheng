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

  def close!
    update_attribute :status, '1'
  end

  def closed?
    status == '1'
  end
  
  ChartColors = {'优' => 'rgb(140, 225, 254)', 
                 '良' => 'rgb(113, 202, 94)', 
                 '中' => 'rgb(226, 36, 62)', 
                 '差' => 'rgb(119, 137, 235)'}
  def to_chart
    total = grades_course.students.size
    us = unsubmit_students.size
    (Settings.homework_levels.map{|h| 
      l = student_homeworks.where(level: h).size
      {y: l, name: to_percent(l, total), color: ChartColors[h]}} +
    [{y: us, name: to_percent(us, total), color: 'rgb(231, 151, 220)'}]).to_json
  end
  include Tool::Percent
end
