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

  # validates :enjoin, presence: true

  def unsubmit_students
    # self.lesson.students - self.students
    self.grades_course.students - self.students
  end
  
  def undo_students
    student_homeworks.where(status: '未批阅')
  end
  
  def of_user(user)
    student_homeworks.where(student_id: user.id).last
  end

  def status_name_for(sh)
    if closed?
      return '未完成' if sh.nil? || sh.new_record?
      return '未批阅' if sh.status == '未批阅'
      return '未改错' if sh.status == '待改错'
      return '完成' if sh.status == '已完成' || sh.status == '已改错'
    end

    sh.nil? ? '待做' : sh.status_name
  end
   
  def section_num_str
    "第#{section.num.to_s}课"
  end
 
  def short_name
    tiny_name 
  end
  
  def tiny_name
    "#{section.try(:name)}-作业#{num}"
  end

  def full_name
    # grades_course.try(:full_name).to_s + tiny_name 
    tiny_name 
  end

  def close!
    update_attribute :status, '1'
  end

  def closed?
    status == '1' || grades_course.try(:closed?)
  end

  def opt_ids
    exercises.map{|e| e.options.map &:id}.flatten
  end

  def exercises_opted_ids
    exercises.where(qtype_id: 2).map &:id
  end

  def teacher
    grades_course.try :teacher
  end

  def need_modify
    student_homeworks.where(status: '待改错').map(&:student)
  end

  def finish_rate(int = false)
    unless closed?
      return '正在进行中' if created_at > 2.days.ago
      return '尚无学生提交' if student_homeworks.empty?
    end
    shs = select_check_hs(student_homeworks.joins(:homework), 'under', 'created_at')
    dones = select_check_hs(student_homeworks.joins(:homework))
    fp = to_percent(dones.size, shs.size)
    fp == 0 ? '0%' : fp
  end

  def oneday_done
    select_check_hs(student_homeworks.joins(:homework))
  end
  
  def oneday_undone
    select_check_hs(student_homeworks.joins(:homework), 'under', 'created_at') - oneday_done
  end
  
  ChartColors = {'优' => 'rgb(140, 225, 254)', 
                 '良' => 'rgb(113, 202, 94)', 
                 '中' => 'rgb(226, 36, 62)', 
                 '差' => 'rgb(119, 137, 235)'}
  def to_chart(percents = true)
    total = grades_course.students.size
    us = unsubmit_students.size
    (Settings.homework_levels.map{|h| 
      l = student_homeworks.where(level: h).size
      {y: l, name: (percents ? to_percent(l, total) : l), color: ChartColors[h]} if l > 0
      }.compact +
    [{y: us, name: (percents ? to_percent(us, total) : us), color: 'rgb(231, 151, 220)'}]).to_json
  end
  include Tool::Percent
  
  class << self
    def show_status
      %w(待改错 已完成)
    end
  end
end
