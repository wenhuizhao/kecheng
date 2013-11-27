# -*- encoding : utf-8 -*-
class GradeStudent < ActiveRecord::Base
  attr_accessible :class_num, :grade_num, :student_id, :is_accept

  belongs_to :student, class_name: 'User'

  def approved
    update_attribute :is_accept, true
  end
end
