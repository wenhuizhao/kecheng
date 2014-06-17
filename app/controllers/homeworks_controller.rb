# -*- encoding : utf-8 -*-
class HomeworksController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_homework, except: [:index, :create, :new, :wait_todo, :view]
  before_filter :require_teacher, except: [:show, :wait_todo]
  before_filter :get_section, except: [:check, :wait_todo]
  
  def index
    @homeworks = @section.homeworks 
  end
  def view
    @homework = @section.homeworks.new
  end
  def show
    @teacher = User.find(params[:teacher_id]) if params[:teacher_id]
    unless current_user.is_student?
      @unsubmit_students = @homework.unsubmit_students
    else
      @student_homework = StudentHomework.where(homework_id: @homework, student_id: current_user.id).last || StudentHomework.new
    end
  end

  def check
    @student_homeworks = @homework.student_homeworks.need_check
    @student_homeworks = @homework.student_homeworks.select{|h| h.status == params[:status]} if params[:status]
    @student_homework = if params[:student_id]
                          StudentHomework.where(student_id: params[:student_id], homework_id: params[:id]).last
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
    begin
      @homework.end_time = Time.parse(params[:homework][:end_time].scan(/[\d]+/).join)
    rescue
     return render_alert '时间格式不正确!'
    end
    @homework.num = @section.course_homeworks(@grades_course).size + 1
    if @homework.save
      redirect_to grades_course_path(@grades_course)
    else
      render action: 'new'
    end
  end

  def prepare
    categories = params[:category_ids]
    section = Section.find(params[:section_id])

    if params[:homework][:work_type] == 'homework'
      @homework = @section.homeworks.new
      @homework.exercises = section.exercises.reject{|e| categories.blank? || !categories.include?(e.category_id.to_s) }
      render action: 'new'
    elsif params[:homework][:work_type] == 'exercise'

    end
  end
  def close
    @homework.close!
    return redirect_to  action: :wait_todo, type: 'undo' if params[:back] == 'wait_todo'
    redirect_to grades_course_path(@grades_course)
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
      @title = '需要改错的作业' + size + '份'
    end
  end

  private

  def get_homework
    @homework = Homework.find(params[:id]) if params[:id]
  end
  
  def get_section
    @grades_course = GradesCourse.find(params[:grades_course_id])
    @section = Section.find(params[:section_id])
  end
end
