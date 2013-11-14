class CoursesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_course, except: [:index, :create, :new]
  
  def index
    @courses = Course.all
  end

  def show
  end

  def edit
  end

  def new
  end

  def update
  end

  def create
  end

  def destroy
  	@course.destroy
  	redirect_to courses_path
  end
  
  private

  def get_course
    @course = Course.find(params[:id])
  end
end
