class StatisticsController < ApplicationController
  
  include Tool::Percent
  
  before_filter :require_admin
  before_filter :month_range

  def index
  end
  
  def teachers
    gid, cid = params[:grade_course_id].split('|')
    @grade_course = GradeCourse.new(gid.to_i, Course.find(cid))
    school_id = current_user.is_admin_xld? ? current_user.school_id : params[:school_id]
    @teachers = @grade_course.teachers(school_id)
  end

  def teacher
    @teacher = User.find(params[:teacher_id])
    @messages = Message.all_for(@teacher) if params[:messages]
    @grades_courses = @teacher.accepted_courses
    @grades_course = params[:grades_course_id] ? GradesCourse.find(params[:grades_course_id]) : @grades_courses[0]
  end
  
  def to_line_chart
    return redirect_with_message '请选择', action: :index unless params[:school_ids] || params[:grade_course_ids] || params[:teacher_ids] 
    @objs = if params[:school_ids]
              School.find(params[:school_ids])
            elsif params[:teacher_ids]
              User.find(params[:teacher_ids])
            elsif params[:grade_course_ids]
              GradeCourse.builds(params[:grade_course_ids].map(&:split))
            end
    @data = @objs.map do |s|
      {
        name: s.name,
        data: @month_range.inject([]) do |pers, m| pers << percents_for(s, m, true) end
      }
    end.to_json
  end

  def set_month_range
    @start_date, @end_date = Date.parse(params[:start_date]), Date.parse(params[:end_date])
    render :index
  end

  private
    def month_range
      @start_year, @end_year = current_period.start_year, 
                               current_period.end_year
      @month_range = Period.current_period.months
    end
end
