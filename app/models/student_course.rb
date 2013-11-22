# -*- encoding : utf-8 -*-
class StudentCourse < ActiveRecord::Base
  attr_accessible :grades_course_id, :note, :score, :student_id

  belongs_to :grades_course
  belongs_to :student, class_name: 'User'
end
