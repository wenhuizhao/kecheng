# -*- encoding : utf-8 -*-
class GradeStudent < ActiveRecord::Base
  attr_accessible :class_num, :grade_num, :student_id

  belongs_to :student, class_name: 'User'
end
