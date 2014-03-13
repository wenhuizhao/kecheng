# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  
  before_filter :authenticate_user!, except: [:set_auth_code, :forget_password]
  before_filter :require_admin, except: [:reset_password, :show, :set_auth_code, :update, :forget_password, :create_user_from_admin]
  before_filter :get_user, except: [:index, :create_user_from_admin, :new, :set_auth_code, :forget_password]
  
  def index
    if current_user.is_admin? 
      @users = User.all
    elsif current_user.is_admin_jyj?
      @users = current_user.jyj.users # .reject{|u| u.is_admin_jyj?}
    elsif current_user.is_admin_xld?
      @users = current_user.school.users.reject{|u| u.is_admin_jyj?}
    else
      @users = []
    end
    @users = page_objs @users
  end

  def show
    return render_alert '无此权限' if @user != current_user && !current_user.admins?
  end

  def edit
    get_grades
  end

  def new
    @user = User.new
    get_grades
  end

  def get_grades
    @grades = if current_user.is_admin?
                Grade.all
              elsif current_user.is_admin_jyj?
                current_user.jyj.grades
              elsif current_user.is_admin_xld?
                current_user.school.grades
              else
                [] 
              end

  end

  def update
    return render_alert('手机号码不正确') if params['user']['phone'].presence && !right_phone(params['user']['phone'])
    if @user.update_attributes(params[:user])
      @user.update_attribute(:role_id, nil) if current_user.is_admin? && current_user.id == @user.id
      if params[:grade_num] 
        grade = Grade.where(school_id: @user.school_id, grade_num: params[:grade_num].to_i, class_num: params[:class_num].to_i).first_or_create 
        GradeStudent.update_from_admin(grade.id, @user.id) if @user.is_student?
      end
      flash[:notice] = '您的修改已保存成功！' 
      re_to_path
    else
      render action: (current_user.is_admin? ? "edit" : "show")
    end
  end

  def create_user_from_admin
    @user = User.new(params[:user])
    if @user.save
      if params[:grade_num]
        grade = Grade.where(school_id: @user.school_id, grade_num: params[:grade_num].to_i, class_num: params[:class_num].to_i).first_or_create
        GradeStudent.build_from_admin(grade.id, @user.id) if @user.is_student?
      end
      @user.update_attribute(:school_id, current_user.school_id) if current_user.is_admin_xld? && !@user.is_admin_jyj?
      re_to_path
    else
      render action: 'new'
    end
  end
  
  def reset_password
    op = params[:old_password]
    return render_alert '旧密码不正确' if request.post? && !current_user.valid_password?(op)
    return render_alert '无此权限' if @user != current_user
    update_pass(current_user)
  end

  def forget_password
    return if request.get?
    return flash[:notice] = '请填写联系方式' unless params[:phone].presence
    user = User.where(phone: params[:phone])[0]
    return render_alert '验证码不正确' if session[:auth_code] != params[:auth_code]
    return render_alert "无此用户" if !user
    update_pass(user)
  end

  def destroy
    @user.destroy
    re_to_path
  end
  
  def set_auth_code
    session[:auth_code] = random_num
    return render text: "请输入正确手机号码" unless right_phone(params[:mobile])
    return render text: "无此联系方式" if params[:forget] && !User.where(phone: params[:mobile])[0]
    send_sms mobile: params[:mobile], content: "您的验证码是：#{session[:auth_code]}，欢迎登录【麦穗儿】！"
    render text: "验证码已发送至#{params[:mobile]}"
  end

  private
  
  def update_pass(user)
    if request.post?
      return render_alert '两次密码输入不一致' if params[:password_confirmation] != params[:password]
      return render_alert '请输入密码' unless params[:password].presence
      user.password = params[:password]
      user.save
      # render_alert '修改成功,请重新登录！'
      flash[:notice] = '您的修改已保存成功！' 
    end
  end

  def re_to_path
    return redirect_to @user if params[:profile]
    redirect_to users_path
  end

  def right_phone(phone)
    phone =~  /1[358]+\d[\d]{8}/
  end

  def get_user
    @user = current_user.admins? ? User.find(params[:id]) : current_user
  end
  
end
