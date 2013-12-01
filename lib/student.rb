module Student

  def selected_courses
    StudentCourse.where(student_id: self.id).inject([]) do |courses, sc|
      courses << sc.grades_course
    end.compact
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

  def grade
    grades.last
  end

  def clear_selected_courses
    # StudentCourse.where(student_id: self.id).each {|s| s.delete}
  end
  include Mgrade
end
