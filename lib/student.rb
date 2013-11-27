module Student
  def selected_courses
    StudentCourse.where(student_id: self.id).inject([]) do |courses, sgc|
      courses << sgc.grades_course
    end
  end

  def courses_of_select
    GradesCourse.where(grade_num: self.grade_num, class_num: self.class_num)
  end
  
  def grades
    GradeStudent.where(student_id: self.id).last
  end

  def grades_accept?
    grades.try :is_accept
  end

  def 

  def clear_selected_courses
    # StudentCourse.where(student_id: self.id).each {|s| s.delete}
  end

  def grade_num
    grades.try :grade_num
  end

  def class_num
    grades.try :class_num
  end
end