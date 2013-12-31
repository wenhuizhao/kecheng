class StatisticsController < ApplicationController
  
  include Tool::Percent
  
  def index
    
  end

  def to_line_chart
    @schools = School.all
    @grades = current_user.school.grades
    @month_range = (2..7).to_a
    
    @data = @schools.map do |s|
      {
        name: s.name,
        data: @month_range.inject([]) do |pers, m| pers << percents_for(s, m, true) end
      }
    end.to_json
  end
end
