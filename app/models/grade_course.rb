# -*- encoding : utf-8 -*-
class GradeCourse
  
  attr_reader :grade_num, :course

  def initialize(grade_num, course)
    @grade_num = grade_num.to_i
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

  def grades(school_id = 2)
    Grade.where(grade_num: @grade_num, school_id: school_id)
  end

  def teachers(school_id = 2)
    # homeworks.map{|h| h.teacher}.uniq
    grades(school_id).inject([]) { |ts, g|
    ts << GradesCourse.where("book_id is not null").where(grade_id: g.id, course_id: course_id).map{|g| User.find_by_id(g.teacher_id)} }.flatten.compact.uniq
  end
end
