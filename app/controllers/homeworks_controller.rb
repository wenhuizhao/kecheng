# -*- encoding : utf-8 -*-
class HomeworksController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_homework, except: [:index, :create, :new, :wait_todo]
  before_filter :require_teacher, except: [:show, :wait_todo]
  before_filter :get_section, except: [:check, :wait_todo]
  
  def index
    @homeworks = @section.homeworks 
  end

  def show
    unless current_user.is_student?
      @unsubmit_students = @homework.unsubmit_students
    else
      @student_homework = StudentHomework.where(homework_id: @homework, student_id: current_user.id).last || StudentHomework.new
    end
  end

  def check
    @student_homeworks = StudentHomework.where(homework_id: params[:id])
    @student_homework = if params[:student_Id]
                          StudentHomework.where(student_id: params[:student_Id], homework_id: params[:id]).last
                        else
                          @student_homeworks.first
                        end
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
    @homework.num = @section.homeworks.size
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
  
  def wait_todo
    if params[:type] == 'undo'
      @homeworks = current_user.undo_homeworks
      size = @homeworks.size.to_s
      @title = current_user.is_student? ? '您要做的作业' + size + '份' : '未完成作业(' + size + ')'
    else
      @homeworks = current_user.need_modify_homeworks
      size = @homeworks.size.to_s
      @title = '您要修改的作业' + size + '份'
    end
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
