# -*- encoding : utf-8 -*-
class GradeCourse
  
  def initialize(grade, course)
    @grade = grade
    @course = course
  end
  
  def name
    full_name
  end
  
  def full_name
    App::ChineseNum[@grade.grade_num] + '年级' + @course.name
  end
  
  def course_id
    @course.id
  end

  def grade_id
    @grade.id
  end
  
  def id
    [grade_id, course_id]
  end

  include Mgrade::Homeworks

  def homeworks
    Homework.joins(:grades_course).where("grades_courses.course_id = #{course_id} and grades_courses.grade_id = #{grade_id} ")
  end

  def self.builds(ids)
    ids.map{|g| GradeCourse.new(Grade.find(g[0]), Course.find(g[1]))}
  end

  def teachers
    GradesCourse.where(grade_id: grade_id, course_id: course_id).map{|g| User.find(g.teacher_id)}
  end
end