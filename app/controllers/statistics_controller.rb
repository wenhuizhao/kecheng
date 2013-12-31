class StatisticsController < ApplicationController
  
  include Tool::Percent
  
  before_filter :month_range

  def index
    
  end

  def to_line_chart
    @objs = current_user.is_admin_jyj? ? School.find(params[:ids]) : Grade.find(params[:ids])
    @data = @objs.map do |s|
      {
        name: s.name,
        data: @month_range.inject([]) do |pers, m| pers << percents_for(s, m, true) end
      }
    end.to_json
  end

  private
    def month_range
      @month_range = (2..7).to_a
    end
end
