# -*- encoding : utf-8 -*-
module ApplicationHelper
  
  include Exts
  
  def into_date(date, format = '%F')
    date.strftime(format)
  end

  def into_datetime(datetime, format = '%F %T')
    datetime.strftime(format)
  end

  def main_btn
  	'btn btn-main'
  end

  def link_to_back
    link_to_function '<span>返回</span>'.html_safe, 'history.go(-1)', class: 'btn ok'
    # link_to_function '返回', 'history.go(-1)'
  end

  def link_to_home
    content_tag :div, (link_to '返回', root_path), class: 'back'
  end
end
