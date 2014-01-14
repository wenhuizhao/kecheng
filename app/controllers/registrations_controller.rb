# -*- encoding : utf-8 -*-
class RegistrationsController < Devise::RegistrationsController
  
  def create
    return render_alert '非法註冊' if params[:user][:role_id].nil?
    return render_alert '验证码不正确' if session[:auth_code] != params[:auth_code]
    return render_alert '联系方式已经存在' if User.where(phone: params[:user][:phone]).size > 0 rescue nil
    super
  end

end
