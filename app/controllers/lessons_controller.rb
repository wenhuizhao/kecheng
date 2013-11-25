# -*- encoding : utf-8 -*-
class LessonsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_grades_course
  before_filter :get_lesson, except: [:index, :create, :new]
  before_filter :require_teacher, except: [:show]
  
  def show
    @homeworks = @lesson.homeworks
  end

  def edit
  end

  def new
    @lesson = Lesson.new
  end

  def update
    if @lesson.update_attributes(params[:lesson])
      redirect_to grades_course_lesson_path(@grades_course, @lesson)
    else
      render action: 'edit'
    end
  end

  def create
    @lesson = Lesson.new(params[:lesson])
    if @lesson.save
      redirect_to grades_course_lesson_path(@grades_course, @lesson)
    else
      render action: 'new'
    end
  end

  def destroy
    @lesson.destroy
    redirect_to grades_course_lesson_path(@grades_course, @lesson)
  end
  
  private

  def get_lesson
    @lesson = @grades_course.lessons.find(params[:id])
    # redirect_to action: :new if @lesson.nil?
  end
  
  def get_grades_course
    @grades_course = GradesCourse.find(params[:grades_course_id])
  end
end
