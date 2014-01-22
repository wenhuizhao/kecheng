module Student
  include Common
  def selected_courses
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

  def need_select_grade?
    !grade && (!grade_stu || grade_accept?)
  end

  def approved_grades
    Grade.joins(:grade_students).where("grades.period_id = #{current_period.id} and grade_students.is_accept = 1 and grade_students.student_id = #{self.id}")
  end

  def grade
    # approved_grades.last
    grade_stus.last.is_accept ? grade_stus.last.grade : nil
  end

  def history_grades
    approved_grades - [grade]
  end

  def need_modify_homeworks
    homeworks.joins(:student_homeworks).where("student_homeworks.status = '待改错'").order('end_time')
  end

  include Mgrade
end
