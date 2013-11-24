# -*- encoding : utf-8 -*-
module ApplicationHelper
  
  def get_grades(c)
    App::ChineseNum[c.grade_num.to_i] + '年级' + App::ChineseNum[c.class_num.to_i] + "班" if c.grade_num
  end
  
  def into_date(date)
    date.strftime('%F')
  end

  def into_datetime(datetime)
    datetime.strftime('%F %T')
  end
end
