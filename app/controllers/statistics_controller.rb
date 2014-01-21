class StatisticsController < ApplicationController
  
  include Tool::Percent
  
  before_filter :require_admin
  before_filter :month_range

  def index
  end
  
  def teachers
    gid, cid = params[:grade_course_id].split('|')
    @grade_course = GradeCourse.new(Grade.find(gid), Course.find(cid))
    @teachers = @grade_course.teachers
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
    start_date, end_date = Date.parse(params[:start_date]), Date.parse(params[:end_date])
    session[:year] = start_date.year
    session[:month_range] = (start_date..end_date).map(&:month).uniq
    redirect_to :index
  end

  private
    def month_range
      @month_range = session[:month_range] || Period.current_period.months
    end
end
