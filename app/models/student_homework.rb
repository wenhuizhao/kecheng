# -*- encoding : utf-8 -*-
class StudentHomework < ActiveRecord::Base
  attr_accessible :homework_id, :status, :student_id

  belongs_to :homework
  belongs_to :student, class_name: 'User'
end
