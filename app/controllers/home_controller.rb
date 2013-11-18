class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_left_courses
  
  def index
  end
  
  def open_courses
    @gc = GradesCourse.create(params[:grc]) if request.post?
  end
end
