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
    @student_homework.status = '待改错' unless @student_homework.all_right?
    if @student_homework.update_attributes(params[:student_homework])
      update_exercises
      return re_to_check if params[:commit] == '提交&下一份'
      reto_homework_path
    else
      render action: 'edit'
    end
  end

  def create
    @student_homework = StudentHomework.new(params[:student_homework])
    @student_homework.student_id = current_user.id
    @student_homework
    if @student_homework.save
      update_exercises
      return re_to_check if params[:commit] == '提交&下一份'
      reto_homework_path
    else
      render action: 'new'
    end
  end

  def destroy
  end
  
  private

  def update_exercises
    homework = @student_homework.homework
    homework.exercises.each do |e|
      she = StudentHomeworksExercises.where(student_homework_id: @student_homework.id, exercise_id: e.id).first_or_create
      if current_user.is_student? && e.qtype_id == 2
        she.update_attribute :answer, params["#{e.id}option"]
      elsif current_user.is_teacher?
        she.update_attributes(teacher_id: current_user.id, check_desc: nil)
      end
    end
  end
   
  def reto_homework_path
    homework = @student_homework.homework
    grades_course, lesson = homework.grades_course, homework.lesson
    render :create
    # flash[:notice] = current_user.is_student? ? '作业提交成功' : '作业批阅成功'
    # redirect_to section_homework_path(homework.section, homework, grades_course_id: grades_course.id)
  end

  def re_to_check
    redirect_to check_homework_path(@student_homework.homework, status: params[:status]) 
  end

  def get_student_homework
    @student_homework = StudentHomework.find(params[:id])
  end
end
