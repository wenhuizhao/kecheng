# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @messages = page_objs current_user.unread_messages
  end

  def settings
  end  
end
