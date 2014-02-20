# encoding: utf-8
require 'net/http'
module Tool
  def send_sms(opts = {})
    default_opts = {
      action: 'send',
      userID: Settings.sms_userid,
      account: Settings.sms_account,
      password: Settings.sms_password
    }
    url = 'http://www.qf106.com/sms.aspx'
    post_data(url, default_opts.merge(opts))
  end

  def post_data(url, pas)
    uri = URI.parse(URI.encode(url))
    http = Net::HTTP.new(uri.host, uri.port) 
    http.use_ssl = true if uri.scheme == 'https'
    req = Net::HTTP::Post.new(uri.path) 
    req.set_form_data(pas)
    res = http.request(req) 
    res.body  
  end
  
  def super_admin
    User.where(role_id: nil).first
  end

  def random_num(len = 6)
    chars = ("0".."9").to_a
    1.upto(len).inject("") { |ma, i| ma << chars[rand(chars.size - 1)] }
  end

  def render_alert(para)
    title, options = "", {}
    title = para if para.is_a?String
    options = para if para.is_a?Hash
    if options[:page_to]
      render_js "window.top.location ='#{options[:page_to]}';"
    elsif options[:turn]
      render_js "alert('#{title}');"
    else
      render_js "window.history.go(-1);alert(\"#{title}\");"
    end
  end
  
  def render_js(js)
    render text: "<script>" + js + "</script>"
  end

  module Percent
    include Common
    def to_percent(n, total, int = false)
      num = (n/total.to_f * 100).round(2)
      return 0 if total == 0
      return num if int
      num.to_s + "%"
    end

    def percents_for(obj, month, int = false, year = current_period.start_year, opts = [])
      year = year.to_i + 1 if (1..7).to_a.include?(Time.now.month) # month == 1
      percent_between(obj, "#{year}-#{month}-01", "#{year}-#{month}-31", int, opts)
    end
  
    def range_percents_homework(objs, sdate, edate)
      objs.map {|obj| percent_between(obj, sdate, edate, true) }
    end
    
    def percent_between(obj, sdate, edate, int = false, opts = [])
      total = obj.homework_rang(sdate, edate).where("grades_courses.is_open = 1 and (homeworks.created_at < '#{2.days.ago.to_s[0, 19]}' or homeworks.status = '1')")
      total = obj.is_a?(GradeCourse) ? total.where("grades.school_id = #{params[:school_id] || current_user.school_id}") : total
      total_shs = total.map{|h| select_check_hs(h.student_homeworks.joins_opts(opts), 'under', 'created_at')}.flatten
      total_done_shs = total.map{|h| select_check_hs(h.student_homeworks.joins_opts(opts))}.flatten
      to_percent(total_shs.size - total_done_shs.size, total_shs.size, int)
    end

    def select_check_hs(objs, type = 'under', date_str = 'first_update')
      s = "student_homeworks"
      objs.select("#{s}.id,#{s}.status,#{s}.times,#{s}.student_id,#{s}.updated_at,unix_timestamp(#{s}.#{date_str})-unix_timestamp(homeworks.created_at) as s").inject([]) do |ss, h|
        if type == 'over'
          h.s && h.s > 48 * 60 * 60 ? ss << h : ss
        elsif type == 'empty'
          h.s.nil? ? ss << h : ss
        else
          h.s && h.s < 48 * 60 * 60 ? ss << h : ss
        end
      end
    end
  end

end
