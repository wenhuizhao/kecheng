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
    @course = Course.new
  end

  def update
    if @course.update_attributes(params[:course])
      redirect_to courses_path
    else
      render action: 'edit'
    end
  end

  def create
    @course = Course.new(params[:course])
    if @course.save
      redirect_to courses_path
    else
      render action: 'new'
    end
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
