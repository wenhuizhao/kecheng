# -*- encoding : utf-8 -*-
class GradesCoursesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_grades_course, except: [:index, :create, :new]
  
  def index

  end

  def show
  end

  def edit
  end

  def new
    @grades_course = GradesCourse.new
  end

  def update
    if @grades_course.update_attributes(params[:grades_course])
      do_lessons
      redirect_to grades_courses_path
    else
      render action: 'edit'
    end
  end

  def create
    @grades_course = GradesCourse.new(params[:grades_course])
    @grades_course.teacher_id = current_user.id 
    if @grades_course.save
      do_lessons
      redirect_to grades_courses_path
    else
      render action: 'new'
    end
  end

  def destroy
    @grades_course.destroy
    redirect_to grades_courses_path
  end
  
  private
  
  def do_lessons
    1.upto(@grades_course.lesson_num.to_i).each do |i|
      Lesson.where(grades_course_id: @grades_course.id, num: i).first_or_create
    end
  end
  
  def get_grades_course
    @grades_course = GradesCourse.find(params[:id])
  end
end
