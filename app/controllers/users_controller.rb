# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :require_admin, except: [:reset_password, :show]
  before_filter :get_user, except: [:index, :create_user_from_admin, :new]
  
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
  end

  def new
    @user = User.new
  end

  def update
    if @user.update_attributes(params[:user])
      GradeStudent.update_from_admin(params[:grade_id], @user.id) if @user.is_student?
      @user.update_attribute(:role_id, nil) if current_user.is_admin? && current_user.id == @user.id
      redirect_to users_path
    else
      render action: 'edit'
    end
  end

  def create_user_from_admin
    @user = User.new(params[:user])
    if @user.save
      GradeStudent.build_from_admin(params[:grade_id], @user.id) if @user.is_student?
      @user.update_attribute(:school_id, current_user.school_id) if current_user.is_admin_xld? && !@user.is_admin_jyj?
      redirect_to users_path
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
    redirect_to users_path
  end
  
  private

  def get_user
    @user = User.find(params[:id])
  end
  
end
