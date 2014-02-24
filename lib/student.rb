# -*- encoding : utf-8 -*-
module Student
  include Common
  
  def selected_courses
    courses
  end

  # def diff_courses
    # courses.group('course_id') rescue []
  # end

  def courses
    gcs = grade.try(:grades_courses)
    gcs ? gcs.visiable : []
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
    Grade.joins(:grade_students).where("grade_students.is_accept = 1 and grade_students.student_id = #{self.id}")
  end

  def grade
    # approved_grades.last
    return nil if is_teacher? || !grade_stus.last
    grade_stus.last.is_accept ? grade_stus.last.grade : grade_stus.where(is_accept: true).last.try(:grade)
  end

  def history_grades
    approved_grades - [grade]
  end

  def need_modify_homeworks
    homeworks.where('homeworks.status is null').joins(:student_homeworks).where("student_homeworks.status = '待改错'").order('end_time').joins(:grades_course).where("grades_courses.is_open = true")
  end

  include Mgrade
end
