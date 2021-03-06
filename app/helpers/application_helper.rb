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

  def only_can_see?(status)
    Homework.show_status.include?(status) || current_user.admins?
  end

  def link_to_back(title = '返回', right = true)
    return link_to_function "<span>#{title}</span>".html_safe, 'history.go(-1)', class: 'btn ok' unless right
    a = link_to_function title, 'history.go(-1)'
    content_tag :div, a, class: 'back lback'
  end

  # def link_back(link = session[:back])
  def link_back(link = root_path)
    content_tag :div, (link_to '返回', link), class: 'back lback'
  end

  def link_to_home
    link_back
  end

  def check_all(selector = 'select_all', tag = 'body')
    c = check_box_tag selector, '', false, onClick: "select_all_records(this,'#{tag}')"
    c + content_tag(:span, '全选')
  end
  
  def get_hexer(e_id, s_id = @student_homework.id)
    StudentHomeworksExercises.where(student_homework_id: s_id, exercise_id: e_id).last
  end

  def get_canvas_text(e_id)
    get_hexer(e_id).try(:canvas).to_s.html_safe
  end

  def get_cwexer(e_id, s_id = @student_classroomwork.id)
    StudentClassroomworksExercises.where(student_classroomwork_id: s_id, exercise_id: e_id).last
  end
  def get_cw_canvas_text(e_id)
    get_cwexer(e_id).try(:canvas).to_s.html_safe
  end

  def need_canvas
    %w(exercises homeworks classroomworks)
  end

  def partial_role(part = '')
    return "student#{part}" if current_user.is_student?
    "teacher#{part}"
  end

  def paginate_objs(objs)
    paginate objs
  end

  def avatar_path(user)
    return '/assets/deleted-avatar.png' if user.nil?
    return '/assets/avatar.png' if user.admins?
    "/assets/#{user.role.en_name}-#{user.gender_name}.png"
  end

  def link_green_btn(title, opts = {})
    link_to title, opts, class: 'btn'
  end
  
  def red_content(words, opts = {})
    content_tag :span, words, {class: 'red', style: "font-weight: bold;"}.merge(opts)
  end

  def replaced_exercise(exer, ans = nil)
    content = clean_content(exer.title, {}, wrapper_tag: "div")
    return content.html_safe if exer.is_lianxian?
    cs = ""
    contents = blanks_arr(content, exer.qtype_id)
    # contents = simple_format(exer.title).split(/\<u\>.*?\<\/u\>/)
    contents.each_with_index do |c, i|
      cs += c
      next if c.empty? || c == "</span><span>"
      if c == contents.last
        if exer.is_q_and_a? && !exer.is_math_qa?
          cs += "<textarea name='#{exer.id}_#{i + 1}_in'  id='text#{exer.id}' cols=50  rows=5 class='qa_area'>#{ans.to_s.split("@@@")[i]}</textarea>" 
        end
      else
        val = ans.to_s.split("@@@")[i].to_s.gsub(" ",'')
        if exer.is_fill_blank? || exer.is_multi_choice? 
          cs += "<input name='#{exer.id}_#{i + 1}_in' value='#{val}' class='exer_input' />"
        else
          cs += "<textarea name='#{exer.id}_#{i + 1}_in' id='text#{exer.id}' cols=50 class='exer_textarea'>#{val}</textarea>" 
        end
      end
    end
    cs.gsub('@@@','').html_safe
  end
  
  def flash_notice
    notice = flash[:notice] || @notice || @error
    content_tag :div, notice, class: 'unotice' if notice
  end

  def month_into_date(month, year = current_period.start_year, day = '1')
    "#{year}-#{month}-#{day}"
  end
 
  def clean_content(c, opts = {}, opts2 = {})
    simple_format(c, opts, opts2.merge(sanitize: false)).gsub(/[\<&lt;]+!--\[.*?\]-->/,'').html_safe 
  end
 
  def include_tabs
    javascript_include_tag('tab') + stylesheet_link_tag('tab')
  end

  def include_chart_js
    javascript_include_tag 'highcharts','exporting'
  end

  def include_date_picker_js
    javascript_include_tag "/javascripts/My97DatePicker/WdatePicker.js"
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
            tooltip: { enabled: false },
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
            tooltip: { enabled: false },
            #{y_label}
            ,
            series: #{options[:data]}
          });"
    chart(js)
  end

  def y_label(s = "this.value +'%'")
    "yAxis: {
        min: 0,
        max: 100,
        title: {
            text: 'Temperature'
        },
        labels: {
            formatter: function() {
                return #{s}
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
           tooltip: { enabled: false },
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

  def section_name(s)
    
  end
end
