# -*- encoding : utf-8 -*-
class GradeCourse
  
  def initialize(grade_num, course)
    @grade_num = grade_num
    @course = course
  end
  
  def name
    full_name
  end
  
  def full_name
    "#{App::ChineseNum[@grade_num]}年级#{@course.name}"
  end
  
  def course_id
    @course.id
  end

  def id
    [@grade_num, course_id]
  end

  include Mgrade::Homeworks

  def homeworks
    Homework.joins(grades_course: :grade).where("grades_courses.course_id = #{course_id} and grades.grade_num = #{@grade_num}")
  end

  def self.builds(ids)
    ids.map{|g| GradeCourse.new(g[0], Course.find(g[1]))}.uniq
  end

  def grades
    Grade.where(grade_num: @grade_num)
  end

  def teachers
    homeworks.map{|h| h.teacher}.uniq
    # grades.inject([]) { |ts, g| 
    # ts << GradesCourse.where(grade_id: g.id, course_id: course_id).map{|g| User.find(g.teacher_id)} }.flatten
  end
end