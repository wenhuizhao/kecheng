# -*- encoding : utf-8 -*-
class GradeStudent < ActiveRecord::Base
  attr_accessible :grade_id, :student_id, :is_accept

  belongs_to :student, class_name: 'User'
  belongs_to :grade

  include Mgrade

  def approved
    update_attribute :is_accept, true
  end
end
