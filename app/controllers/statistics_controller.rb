class StatisticsController < ApplicationController
  
  include Tool::Percent
  
  before_filter :month_range

  def index
    
  end

  def to_line_chart
    return redirect_with_message '请选择', action: :index if params[:ids].nil?
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
      @month_range = (8..12).to_a
    end
end
