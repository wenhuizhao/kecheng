module Teacher
  
  def accepted_courses
    GradesCourse.accepted_courses_of(self).visiable.group('grade_id').order('grade_id')
  end
  
  def wait_to_accept_courses
    GradesCourse.all_courses_of(self).where(is_accept: nil)
  end

  def history_courses
    # GradesCourse.all_courses_of(self).select{|g| !g.period.current?}
    GradesCourse.all_courses_of(self).where(is_open: false)
  end
  
  def tgrades
    accepted_courses.inject([]){|tgs, pgc| tgs << pgc.grade}.uniq
  end

  include Mgrade::Homeworks
end
