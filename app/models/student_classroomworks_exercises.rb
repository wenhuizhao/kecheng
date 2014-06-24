class StudentClassroomworksExercises < ActiveRecord::Base
  attr_accessible :canvas, :exercise_id, :student_classroomwork_id, :answer, :teacher_id, :check_desc
  has_many :questions, foreign_key: "student_classroomworks_exercise_id", class_name: 'ClassroomworkQuestions'

  def right
    check_desc =~ /right/ || check_desc =~ /niubi/
  end

  def wrong
    check_desc =~ /wrong/
  end
end
