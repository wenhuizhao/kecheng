module Teacher
  
  def accepted_courses
    GradesCourse.accepted_courses_of(self) 
  end
  
  def tgrades
    accepted_courses.inject([]){|tgs, pgc| tgs << pgc.grade}.uniq
  end

  def teachers
    # self.class.teachers.select
  end
end
