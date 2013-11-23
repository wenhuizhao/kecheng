module Teacher
  def opened_courses
    GradesCourse.where(teacher_id: self.id) 
  end
end