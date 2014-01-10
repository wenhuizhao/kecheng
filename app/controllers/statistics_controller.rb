class StatisticsController < ApplicationController
  
  include Tool::Percent
  
  before_filter :month_range

  def index
  end
  
  def teachers
    @teachers = if current_user.is_admin_jyj?
                  current_user.jyj.teachers
                else
                  current_user.school.teachers
                end
  end
  
  def to_line_chart
    return redirect_with_message '请选择', action: :index unless params[:school_ids] || params[:grades_course_ids] || params[:teacher_ids] 
    @objs = if params[:school_ids]
              School.find(params[:school_ids])
            elsif params[:teacher_ids]
              User.find(params[:teacher_ids])
            elsif params[:grades_course_ids]
              GradesCourse.find(params[:grades_course_ids])
            end
    @data = @objs.map do |s|
      {
        name: s.name,
        data: @month_range.inject([]) do |pers, m| pers << percents_for(s, m, true) end
      }
    end.to_json
  end

  private
    def month_range
      @month_range = Period.current_period.months
    end
end
