# -*- encoding : utf-8 -*-
module ApplicationHelper
  
  include Tool::Percent
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

  # def link_back(link = session[:back])
  def link_back(link = root_path)
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
  
  def percents_for(obj, month)
    # total = obj.homeworks_of(month)
    total = obj.homeworks
    day_un_homeworks = total.select{|h| h.status.nil?}
    to_percent(day_un_homeworks.size, total.size)
  end

  def range_percents_homework(objs, sdate, edate)
    objs.map do |obj|
      total = obj.homework_rang(sdate, edate)
      day_un_homeworks = total.select{|h| h.status.nil?}
      to_percent(day_un_homeworks.size, total.size, true)
    end
  end

  def include_chart_js
    javascript_include_tag 'highcharts','exporting'
  end

  def bar_chart(hid, options = {})
    js = "$('#" + hid + "').highcharts({
            chart: {
                type: 'bar'
            },
            title: {
                text: '#{options[:title]}'
            },
            xAxis: {
                categories: #{options[:categories]}
            },
            yAxis: {
                min: 0,
                max: 100
            },
            series: [{
                data: #{options[:percents]}
            }]
        });"
    chart(js)
  end
  
  def pie_chart(obj, options = {})
    js = "$('#" + obj.id.to_s + "').highcharts({
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
           title: {
              text: '#{obj.full_name}'
           },
           series: [{
             type: 'pie',
             name: '" + options[:title] + "',
             innerSize: '80%',
             data: #{options[:data]}
           }]
         });"
    chart(js)
  end

  def chart(js)
    javascript_tag "$(function () {#{js}});"
  end
end
