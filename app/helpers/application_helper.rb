# -*- encoding : utf-8 -*-
module ApplicationHelper
  
  include Exts
  
  def into_date(date)
    date.strftime('%F')
  end

  def into_datetime(datetime)
    datetime.strftime('%F %T')
  end

  def main_btn
  	'btn btn-main'
  end

  def link_to_back
    link_to_function '返回', 'history.go(-1)'
  end
end
