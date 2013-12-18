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

  def history_grades
    grades.select{|g| GradeStudent.where(is_accept: true, student_id: self.id, grade_id: g.id).size > 0}
  end
  
  def clear_selected_courses
    # StudentCourse.where(student_id: self.id).each {|s| s.delete}
  end

  def undo_homeworks
    homeworks.select{|h| StudentHomework.where(student_id: self.id, homework_id: h.id, status: nil).size > 0}
  end

  def need_modify_homeworks
    homeworks.select{|h| StudentHomework.where(student_id: self.id, homework_id: h.id, status: '待改错').size > 0}
  end

  def unread_messages
    messages
  end
  
  include Mgrade
end
