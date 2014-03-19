# -*- encoding : utf-8 -*-
class RegistrationsController < Devise::RegistrationsController
  
  skip_before_filter :require_admin, :require_teacher
  
  def create
    err = []
    err <<  '非法注册' if params[:user][:role_id].nil?
    err <<  '没有选择学校' if params[:user][:school_id].nil?
    err <<  '验证码不正确' if session[:auth_code] != params[:auth_code]
    err <<  '联系方式已经存在' if User.where(phone: params[:user][:phone]).size > 0 rescue nil
    if err.size > 0
      flash[:notice] = err[0]
      redirect_to '/users/sign_up'
    else
      super
    end
  end

  protected

  def after_sign_up_path_for(resource)
    '/'
  end
end
