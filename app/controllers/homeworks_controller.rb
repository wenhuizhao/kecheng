class HomeworksController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_left_courses
  before_filter :get_homework, except: [:index, :create, :new]
  before_filter :require_teacher
  before_filter :get_grades_course
  
  def index
    @homeworks = @grades_course.homeworks 
  end

  def show
  end

  def edit
  end

  def new
    @homework = Homework.new
  end

  def update
    if @homework.update_attributes(params[:homework])
      redirect_to homeworks_path
    else
      render action: 'edit'
    end
  end

  def create
    @homework = Homework.new(params[:homework])
    if @homework.save
      redirect_to homeworks_path
    else
      render action: 'new'
    end
  end

  def destroy
    @homework.destroy
    redirect_to homeworks_path
  end
  
  private

  def get_homework
    @homework = Homework.find(params[:id])
  end
  
  def get_grades_course
    @grades_course = GradesCourse.find(params[:grades_course_id])
  end
end
