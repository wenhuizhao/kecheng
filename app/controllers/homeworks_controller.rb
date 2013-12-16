# -*- encoding : utf-8 -*-
class HomeworksController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_homework, except: [:index, :create, :new]
  before_filter :require_teacher, except: [:show]
  before_filter :get_section, except: [:check]
  
  def index
    @homeworks = @section.homeworks 
  end

  def show
    unless current_user.is_student?
      @unsubmit_students = @homework.unsubmit_students
    else
      @student_homework = @homework.student_homeworks.last || StudentHomework.new
    end
  end

  def check
    @student_homework = StudentHomework.where(student_id: params[:student_id], homework_id: params[:id]).last
  end

  def edit
  end

  def new
    @homework = @section.homeworks.new
  end

  def update
    if @homework.update_attributes(params[:homework])
      redirect_to grades_course_path(@grades_course)
    else
      render action: 'edit'
    end
  end

  def create
    @homework = @section.homeworks.new(params[:homework])
    if @homework.save
      redirect_to grades_course_path(@grades_course)
    else
      render action: 'new'
    end
  end

  def destroy
    @homework.destroy
    redirect_to grades_course_path(@grades_course)
  end
  
  private

  def get_homework
    @homework = Homework.find(params[:id])
  end
  
  def get_section
    @grades_course = GradesCourse.find(params[:grades_course_id])
    @section = Section.find(params[:section_id])
  end
end
