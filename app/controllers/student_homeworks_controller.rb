# -*- encoding : utf-8 -*-
class StudentHomeworksController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_student_homework, except: [:index, :create, :new]
  
  def index
    @student_homeworks = StudentHomework.all
  end

  def show
  end

  def edit
  end

  def new
    @student_homework = StudentHomework.new
  end

  def update
    if @student_homework.update_attributes(params[:student_homework])
      reto_homework_path
    else
      render action: 'edit'
    end
  end

  def create
    @student_homework = StudentHomework.new(params[:student_homework])
    @student_homework.student_id = current_user.id
    if @student_homework.save
      reto_homework_path
    else
      render action: 'new'
    end
  end

  def destroy
  end
  
  private
   
  def reto_homework_path
    homework = @student_homework.homework
    grades_course, lesson = homework.grades_course, homework.lesson
    flash[:notice] = current_user.is_student? ? '作业提交成功' : '作业批阅成功'
    redirect_to grades_course_lesson_homework_path(grades_course, lesson, homework)
  end

  def get_student_homework
    @student_homework = StudentHomework.find(params[:id])
  end
end
