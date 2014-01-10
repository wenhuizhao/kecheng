module Student
  include Common
  def selected_courses
    #  StudentCourse.where(student_id: self.id).inject([]) do |courses, sc|
    #    courses << sc.grades_course
    #  end.compact
    courses
  end

  def courses
    gcs = grade.try(:grades_courses)
    gcs ? gcs.where(is_accept: true) : []
  end 
  
  def grade_stus
    GradeStudent.where(student_id: self.id)
  end

  def grade_stu
    grade_stus.last
  end
  
  def grade_accept?
    grade_stu.try :is_accept
  end

  def approved_grades
    Grade.joins(:grade_students).where("grades.period_id = #{current_period.id} and grade_students.is_accept = 1 and grade_students.student_id = #{self.id}")
  end

  def grade
    approved_grades.last
  end

  def history_grades
    approved_grades - [grade]
  end
  
  def clear_selected_courses
    # StudentCourse.where(student_id: self.id).each {|s| s.delete}
  end

  def need_modify_homeworks
    homeworks.select{|h| StudentHomework.where(student_id: self.id, homework_id: h.id, status: '待改错').size > 0}
  end

  include Mgrade
end
