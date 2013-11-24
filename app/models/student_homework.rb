# -*- encoding : utf-8 -*-
class StudentHomework < ActiveRecord::Base
  attr_accessible :homework_id, :status, :student_id, :score, :level

  belongs_to :homework
  belongs_to :student, class_name: 'User'

  before_create :set_status

  def set_status
    status = Settings.homework_status.first
  end
end
