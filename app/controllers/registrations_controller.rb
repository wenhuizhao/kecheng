# -*- encoding : utf-8 -*-
class RegistrationsController < Devise::RegistrationsController
  
  def create
    return render text: '非法註冊' if params[:user][:role_id].nil?
    super
  end

end
