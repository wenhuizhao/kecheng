class ChangeTeacherLog < ActiveRecord::Base
  attr_accessible :admin_id, :curr_teacher_id, :grades_course_id, :prev_teacher_id, :new_grades_course_id, :message_id
end
