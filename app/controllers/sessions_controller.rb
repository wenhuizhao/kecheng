class SessionsController < Devise::SessionsController
  
  def new
    super
    session["user_return_to"] = request.referrer
  end

  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    redirect_to after_sign_in_path_for(resource)
    current_user.set_bg_num
  end

end