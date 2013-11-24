# -*- encoding : utf-8 -*-
class RegistrationsController < Devise::RegistrationsController
  
  def create
    return render text: '非法註冊' if params[:user][:role_id].nil?
    # resource.first_name, esource.last_name = get_names params[:real_name]
    super
  end

  # private
  #   def get_names(name)
  #     if name.include?(' ')
  #       name.split(' ')
  #     else
  #       [name[1,5], name[0]]
  #     end
  #   end
end
