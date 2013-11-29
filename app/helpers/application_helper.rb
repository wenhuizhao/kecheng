# -*- encoding : utf-8 -*-
module ApplicationHelper
  
  include Exts
  
  def into_date(date)
    date.strftime('%F')
  end

  def into_datetime(datetime)
    datetime.strftime('%F %T')
  end
end
