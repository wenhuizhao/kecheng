# -*- encoding : utf-8 -*-
class ClassroomworksController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_classroomwork, except: [:index, :create, :new, :wait_todo, :view]
  before_filter :require_teacher, except: [:show, :wait_todo, :show_exercise, :records]
  before_filter :get_section, except: [:check, :wait_todo]

  def index
    @classroomworks = @section.classroomworks
  end

  def show
    @teacher = User.find(params[:teacher_id]) if params[:teacher_id]
    unless current_user.is_student?
      @unsubmit_students = @classroomwork.unsubmit_students
    else
      @student_classroomwork = StudentClassroomwork.where(classroomwork_id: @classroomwork, student_id: current_user.id).last || StudentClassroomwork.new
    end
  end

  def check
    @student_classroomworks = @classroomwork.student_classroomworks.need_check
    @student_classroomworks = @classroomwork.student_classroomworks.select{|h| h.status == params[:status]} if params[:status]
    @student_classroomwork = if params[:student_id]
                          StudentClasroomwork.where(student_id: params[:student_id], classroomwork_id: params[:id]).last
                        else
                          @student_classroomworks.first
                        end
  end

  def edit
  end

  def new
    @classroomwork = @section.classroomworks.new
  end

  def update
    if @classroomwork.update_attributes(params[:classroomwork])
      redirect_to grades_course_path(@grades_course)
    else
      render action: 'edit'
    end
  end

  def create
    @classroomwork = @section.classroomworks.new(params[:classroomwork])
    begin
      @classroomwork.end_time = Time.parse(params[:classroomwork][:end_time].scan(/[\d]+/).join)
    rescue
      return render_alert '时间格式不正确!'
    end
    @classroomwork.num = @section.course_classroomworks(@grades_course).size + 1
    if @classroomwork.save
      redirect_to grades_course_path(@grades_course)
    else
      render action: 'new'
    end
  end

  def close
    @classroomwork.close!
    return redirect_to  action: :wait_todo, type: 'undo' if params[:back] == 'wait_todo'
    redirect_to grades_course_path(@grades_course)
  end

  def destroy
    @classroomwork.destroy
    redirect_to grades_course_path(@grades_course)
  end

  def wait_todo
    if params[:type] == 'undo'
      @classroomworks = current_user.undo_classroomworks
      size = @classroomworks.size.to_s
      @title = current_user.is_student? ? '您要做的作业' + size + '份' : '未完成作业(' + size + ')'
    else
      @classroomworks = current_user.need_modify_classroomworks
      size = @classroomworks.size.to_s
      @title = '需要改错的作业' + size + '份'
    end
  end

  def records
    @classroomwork = Classroomwork.where(:section_id=>@section.id, :grades_course_id => @grades_course.id).last
  end

  def show_exercise
    @classroomwork = Classroomwork.where(:section_id=>@section.id, :grades_course_id => @grades_course.id).last
    @exercise = Exercise.find(params[:exercise_id])
  end
  def update_exercise

  end
  private

  def get_classroomwork
    @classroomwork = Classroomwork.find(params[:id]) if params[:id]
  end

  def get_section
    @grades_course = GradesCourse.find(params[:grades_course_id])
    @section = Section.find(params[:section_id])
  end
end
