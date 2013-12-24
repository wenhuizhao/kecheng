# -*- encoding : utf-8 -*-
class StudentHomework < ActiveRecord::Base
  attr_accessible :homework_id, :status, :student_id, :score, :level

  belongs_to :homework
  belongs_to :student, class_name: 'User'

  before_create :set_status

  def set_status
    self.status = Settings.homework_status.first
  end

  def status_name
    status.nil? ? '未做' : status
  end

  def has_score?
  	self.score && !self.score.empty?
  end

  def score_num
    has_score? ? score : '暂无打分'
  end

  def self.to_chart()
    
  end
end
