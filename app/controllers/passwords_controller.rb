# -*- encoding : utf-8 -*-
class PasswordsController < Devise::PasswordsController
  
  def create
    render_alert 'send sms'
  end

end
