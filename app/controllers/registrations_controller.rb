# -*- encoding : utf-8 -*-
class RegistrationsController < Devise::RegistrationsController
  
  def create
    return render text: '非法註冊' if params[:user][:role_id].nil?
    build_resource(sign_up_params)
    
    # resource = User.new(params[:user])
    if resource.save
      redirect_to root_path
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

end
