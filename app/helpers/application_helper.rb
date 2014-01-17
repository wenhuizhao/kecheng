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

  def link_to_back(right = true)
    return link_to_function '<span>返回</span>'.html_safe, 'history.go(-1)', class: 'btn ok' unless right
    a = link_to_function '返回', 'history.go(-1)'
    content_tag :div, a, class: 'back'
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

  def partial_role(part)
    return "student_#{part}" if current_user.is_student?
    "teacher_#{part}"
  end

  def paginate_objs(objs)
    paginate objs
  end

  def avatar_path(user)
    return '/assets/avatar.png' if user.admins?
    "/assets/#{user.role.en_name}-#{user.gender_name}.png"
  end

  def link_green_btn(title, opts = {})
    link_to title, opts, class: 'btn'
  end
  
  def range_percents_homework(objs, sdate, edate)
    objs.map do |obj|
      total = obj.homework_rang(sdate, edate)
      day_un_homeworks = total.select{|h| h.status.nil?}
      to_percent(day_un_homeworks.size, total.size, true)
    end
  end
  
  def red_content(words, opts = {})
    content_tag :span, words, {class: 'red', style: "font-weight: bold;"}.merge(opts)
  end

  def replaced_exercise(exer, ans = nil)
    content = simple_format(exer.title, {}, wrapper_tag: "div")
    return content.html_safe if exer.is_multi_choice? || exer.is_need_canvas?
    cs = ""
    contents = blanks_arr(content, exer.qtype_id)
    # contents = simple_format(exer.title).split(/\<u\>.*?\<\/u\>/)
    contents.each_with_index do |c, i|
      next if c.empty? || c == "</span><span>"
      unless c == contents.last
        if exer.is_fill_blank?
          cs +=  c + "<input name='#{exer.id}_#{i + 1}_in' value='#{ans.to_s.split("@@@")[i]}' class='exer_input' />"
        else
          cs +=  c + "<textarea name='#{exer.id}_#{i + 1}_in' cols=50 class='exer_textarea'>#{ans.to_s.split("@@@")[i]}</textarea>" 
        end
      end
    end 
    cs.html_safe
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
            #{y_label},
            series: [{
              name: '#{options[:time_str]}',
              data: #{options[:percents]}
            }]
        });"
    chart(js)
  end
  
  def line_chart(hid, options = {})
    js = "$('#" + hid + "').highcharts({
            title: '',
            xAxis: {
              categories: #{options[:categories]}
            },
            #{y_label}
            ,
            series: #{options[:data]}
          });"
    chart(js)
  end

  def y_label
    "yAxis: {
        min: 0,
        max: 100,
        title: {
            text: 'Temperature'
        },
        labels: {
            formatter: function() {
                return this.value +'%'
            }
        }
      }"
  end

  def pie_chart(obj, options = {})
    js = "$('#" + obj.id.to_s + "').highcharts({
           plotOptions: {
             pie: {
                 dataLabels: {
                     enabled: true,
                     distance: -10,
                     style: {
                         fontWeight: 'bold',
                         color: 'white',
                         textShadow: '0px 1px 2px black'
                     }
                   }
                 }
               },
           title: {
              text: '#{options[:title] || obj.full_name}'
           },
           series: [{
             type: 'pie',
             name: '" + options[:title] + "',
             innerSize: '90%',
             data: #{options[:data]}
           }]
         });"
    chart(js)
  end

  def chart(js)
    javascript_tag "$(function () {#{js}});"
  end
end
