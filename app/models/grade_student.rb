# -*- encoding : utf-8 -*-
class GradeStudent < ActiveRecord::Base
  attr_accessible :grade_id, :student_id, :is_accept

  belongs_to :student, class_name: 'User'
  belongs_to :grade

  include Mgrade
  
  def self.build_from_admin(grade_id, student_id)
    where(grade_id: grade_id, student_id: student_id, is_accept: true).first_or_create
  end

  def self.update_from_admin(grade_id, student_id)
    gs = where(student_id: student_id, is_accept: true).last
    gs ? gs.update_attribute(:grade_id, grade_id) : build_from_admin(grade_id, student_id)
  end
end
