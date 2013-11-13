class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @courses = Course.all
  end

end
