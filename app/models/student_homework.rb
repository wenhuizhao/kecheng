# -*- encoding : utf-8 -*-
class StudentHomework < ActiveRecord::Base
  attr_accessible :homework_id, :status, :student_id, :score, :level, :times

  belongs_to :homework
  belongs_to :student, class_name: 'User'
  has_and_belongs_to_many :exercises, join_table: 'student_homeworks_exercises' 

  before_create :set_status

  # scope :one_day, -> {where("student_homeworks.updated_at < #{1.days.from(created_at})")}
  
  def set_status
    self.status = Settings.homework_status.first
  end

  def status_name
    status.nil? ? '未做' : status
  end

  def has_score?
    self.score && !self.score.empty?
  end
  
  def is_finished?
    status == '已完成'
  end
  
  def canvas_exercises
    exercises.select{|e| e.is_need_canvas?}.uniq
  end

  def score_num
    has_score? ? score : '暂无打分'
  end
  
  def all_right?
    times == 2
  end
  
  def need_modify
    update_attributes(status: '待改错', times: 1)
  end

  def complete
    update_attributes(status: '已完成', times: 2)
  end

  def first_submit?
    homework.student_homeworks[0] == self
  end
end
