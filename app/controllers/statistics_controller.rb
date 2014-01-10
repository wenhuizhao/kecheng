class StatisticsController < ApplicationController
  
  include Tool::Percent
  
  before_filter :month_range

  def index
  end
  
  def teachers
    gid, cid = params[:grade_course_id].split('|')
    @grade_course = GradeCourse.new(Grade.find(gid), Course.find(cid))
    @teachers = @grade_course.teachers
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

  private
    def month_range
      @month_range = Period.current_period.months
    end
end
