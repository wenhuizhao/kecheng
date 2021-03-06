# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  before_filter :authenticate_user!, except: [:check_user]
  
  def index
    @messages = page_objs current_user.unread_messages
  end

  def settings
  end

  def update_books
    return unless params[:course_id]
    books = get_books(params[:grade_num].to_i, Course.find(params[:course_id]))
    render partial: 'shared/update_books', locals: {books: books}
  end

  def set_book
    gce = GradesCourse.find(params[:grades_course_id])
    gce.update_attribute :book_id, params[:book_id]
    gce.pcourse.close! if params[:book_id].presence
    redirect_to grades_course_path(gce)
  end

  CheckCols = {
    "login" => "用户名",   
    "password" => "密码",   
    "password_confirmation" => "验证密码",   
    "real_name" => "真实姓名",   
    "role_id" => "角色",   
    "school_id" => "学校",   
    "phone" => "手机号码",   
    "auth_code" => "验证码"   
  }

  def check_user
    col = params[:hid].to_s.gsub("user_","")
    val = params[:val]
    return render text: "error/#{CheckCols[col]}不能为空！" if val.size == 0
 
    case col
    when 'login'
      if User.where(login: val).count > 0
        err_mess = "用户名已被占用!"
      elsif !(val =~ /^[a-zA-Z0-9]{2,30}$/)
        err_mess = "用户名应当是2-30位的英文字母、数字组合！"
      end
    when 'real_name'
      err_mess = "真实姓名应是2-30位的中文或英文字符!" if !(val =~ /^[a-zA-Z\u4e00-\u9fa5]{2,30}$/)
    when 'password'
      err_mess = "密码应该是6-16位的数字、字母的组合!" if !(val =~ /^[a-zA-Z0-9]{6,16}$/)
      session[:rpass] = val
    when 'password_confirmation'
      err_mess = "两次密码输入不一致!" if session[:rpass] != val
    when 'phone'
      err_mess = "手机号码已被占用!" if User.where(phone: val).count > 0
      err_mess = "手机号码格式不正确!" if !(val =~ /1[358]+\d[\d]{8}/)
    when 'auth_code'
      err_mess = "验证码不正确" if session[:auth_code] != val 
    end
    render text: (err_mess.presence ? "error/#{err_mess}" : 'succ')
  end

  # def submit_user 
  #   err_mess = []
  #   if params['login']
  #     if User.where(login: params['login']).count > 0
  #       err_mess << "用户名已被占用!"
  #     elsif !(params['login'] =~ /^[a-zA-Z0-9]{2,30}$/)
  #       err_mess << "用户名应当是2-30位的英文字母、数字组合！"
  #     end
  #   end

  #   if params['real_name']
  #     err_mess << "真实姓名应是2-30位的中文或英文字符!" if !(params['real_name'] =~ /^[a-zA-Z\u4e00-\u9fa5]{2,30}$/)
  #   end
  #   if params['password']
  #     err_mess << "密码应该是6-16位的数字、字母的组合!" if !(params['password'] =~ /^[a-zA-Z0-9]{6,16}$/)
  #     session[:rpass] = params['password']
  #   end
  #   if params['password_confirmation']
  #     err_mess << "两次密码输入不一致!" if session[:rpass] != params['password_confirmation']
  #   end
  #   if params['phone']
  #     err_mess << "手机号码已被占用!" if User.where(phone: params['phone']).count > 0
  #     err_mess << "手机号码格式不正确!" if !(params['phone'] =~ /1[358]+\d[\d]{8}/)
  #   end
  #   if params['auth_code']
  #     err_mess << "验证码不正确" if session[:auth_code] != params['auth_code']
  #   end
  #   render text: (err_mess.size > 0 ? err_mess[0] : 'succ')
  # end
end
