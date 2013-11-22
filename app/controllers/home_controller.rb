# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end
  
  def open_courses
    @grade_course = GradesCourse.where(params[:grc]).first_or_create if request.post?
  end
end
