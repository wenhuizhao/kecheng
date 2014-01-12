# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  
  before_filter :authenticate_user!, except: [:set_auth_code]
  before_filter :require_admin, except: [:reset_password, :show, :set_auth_code]
  before_filter :get_user, except: [:index, :create_user_from_admin, :new, :set_auth_code]
  
  def index
    if current_user.is_admin? || current_user.is_admin_jyj?
      @users = User.all
    elsif current_user.is_admin_xld?
      @users = current_user.school.users.reject{|u| u.is_admin_jyj?}
    else
      @users = []
    end
    @users = page_objs @users
  end

  def show
    return render text: '无此权限' if @user != current_user
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
          else
            current_user.school.grades
          end

  end

  def update
    if @user.update_attributes(params[:user])
      @user.update_attribute(:role_id, nil) if current_user.is_admin? && current_user.id == @user.id
      GradeStudent.update_from_admin(params[:grade_id], @user.id) if @user.is_student?
      re_to_path
    else
      render action: 'edit'
    end
  end

  def create_user_from_admin
    @user = User.new(params[:user])
    if @user.save
      GradeStudent.build_from_admin(params[:grade_id], @user.id) if @user.is_student?
      @user.update_attribute(:school_id, current_user.school_id) if current_user.is_admin_xld? && !@user.is_admin_jyj?
      re_to_path
    else
      render action: 'new'
    end
  end
  
  def reset_password
    return render text: '无此权限' if @user != current_user
    if request.post?
      return render text: '两次密码输入不一致' if params[:password_confirmation] != params[:password]
      current_user.password = params[:password]
      current_user.save
      flash[:notice] = '修改成功'
    end
  end

  def destroy
    @user.destroy
    re_to_path
  end
  
  def set_auth_code
    session[:auth_code] = random_num
    if params[:mobile] =~ /1[358]+\d[\d]{8}/
      send_sms mobile: params[:mobile], content: "验证码：#{session[:auth_code]}"
      render text: "验证码已发送至#{params[:mobile]}"
    else
      render text: "请输入正确手机号码"
    end
  end

  private
  
  def re_to_path
    return redirect_to current_user if params[:profile]
    redirect_to users_path
  end

  def get_user
    @user = User.find(params[:id])
  end
  
end
