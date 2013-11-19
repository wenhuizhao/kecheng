class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_left_courses
  
  def index
  end
  
  def open_courses
    @grade_course = GradesCourse.where(params[:grc]).first_or_create if request.post?
  end
end
