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

  def link_back(link = session[:back])
    content_tag :div, (link_to '返回', link), class: 'back'
  end

  def link_to_home
    link_back
  end

  def check_all(selector = 'select_all')
    c = check_box_tag selector, '', false, onclick: 'select_all_records()'
    c + content_tag(:span, '全选')
  end
  
  def need_canvas
    %w(exercises homeworks) 
  end

  def paginate_objs(objs)
    paginate objs
  end

  def avatar_path(user)
    'avatar.png'
  end

  def link_green_btn(title, opts = {})
    link_to title, opts, class: 'btn'
  end
 
  def include_chart_js
    javascript_include_tag 'highcharts','exporting'
  end
 
  def chart(*args)
    obj, datas = args[0], args.extract_options!
    javascript_tag "$(function () {
                       $('#" + obj.id.to_s + "').highcharts({
                         plotOptions: {
                           pie: {
                               dataLabels: {
                                   enabled: true,
                                   distance: -15,
                                   style: {
                                       fontWeight: 'bold',
                                       color: 'white',
                                       textShadow: '0px 1px 2px black'
                                   }
                                 }
                               }
                             },
                         series: [{
                           type: 'pie',
                           name: '" + datas[:title] + "',
                           innerSize: '80%',
                           data: #{datas[:data]}
                         }]
                       });
                     });" 
  end
end
