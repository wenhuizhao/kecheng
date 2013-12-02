# -*- encoding : utf-8 -*-
class PasswordsController < Devise::PasswordsController
  
  def create
    render text: 'send sms'
  end

end
