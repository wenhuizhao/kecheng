class StudentHomeworksExercises < ActiveRecord::Base
  attr_accessible :canvas, :exercise_id, :student_homework_id, :answer, :teacher_id, :check_desc
end
