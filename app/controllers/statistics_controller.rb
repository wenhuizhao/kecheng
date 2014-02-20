class StatisticsController < ApplicationController
  
  include Tool::Percent
  
  before_filter :require_admin
  before_filter :month_range

  def index
    @sdate, @edate = params[:start_date] || Date.today.at_beginning_of_month, 
                     params[:end_date] || Date.today.at_end_of_month
  end
  
  def teachers
    index
    gid, cid = params[:grade_course_id].split('|')
    @grade_course = GradeCourse.new(gid.to_i, Course.find(cid))
    school_id = current_user.is_admin_xld? ? current_user.school_id : params[:school_id]
    @teachers = @grade_course.teachers(school_id)
  end

  def oneday_done
    @teacher = User.find(params[:teacher_id])
    @homework = Homework.find(params[:homework_id])
    @grades_course = @homework.grades_course
  end

  def oneday_detail
    oneday_done
  end

  def teacher
    @teacher = User.find(params[:teacher_id])
    @messages = Message.all_for(@teacher) if params[:messages]
    @grades_courses = @teacher.diff_courses
    @grades_course = params[:grades_course_id] ? GradesCourse.find(params[:grades_course_id]) : @grades_courses[0]
    @grades_course = @grades_course.pcourse if @grades_course.has_next_course? 
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
    # @sdate, @edate = Date.parse(params[:start_date]), Date.parse(params[:end_date])
    redirect_to action: params[:from].to_sym, 
                grade_course_id: params[:grade_course_id], 
                school_id: params[:school_id], 
                start_date: params[:start_date], 
                end_date: params[:end_date] 
  end

  private
    def month_range
      sdate, edate = 6.months.ago.to_date, Date.today
      @start_year, @end_year = sdate.year, 
                               edate.year
      @month_range = (sdate..edate).to_a.map{|t| t.month}.uniq 
      # @month_range = Period.current_period.months
    end
end
