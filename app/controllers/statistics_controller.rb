class StatisticsController < ApplicationController
  
  include Tool::Percent
  
  before_filter :month_range

  def index
    
  end

  def to_line_chart
    return redirect_with_message '请选择', action: :index unless params[:school_ids] || params[:grades_course_ids] 
    @objs = params[:school_ids] ? School.find(params[:school_ids]) : GradesCourse.find(params[:grades_course_ids])
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
