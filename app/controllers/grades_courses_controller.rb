# -*- encoding : utf-8 -*-
class GradesCoursesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_grades_course, except: [:index, :create, :new, :select, :select_grades]
  before_filter :require_teacher, except: [:select, :select_grades, :show]

  def index
  end

  def show
  end

  def edit
  end
  
  def select
    redirect_to select_grades_path unless current_user.grades_accept?
    if request.post?
      params[:student][:course_ids].each do |gcid|
        StudentCourse.where(grades_course_id: gcid.to_i, student_id: current_user.id).first_or_create
      end rescue nil # current_user.clear_selected_courses
      flash[:notice] = '保存成功'
    end
    @all_courses = current_user.courses_of_select
  end

  def select_grades
    return unless request.post?
    h = {grade_num: params[:grade_num], class_num: params[:class_num]}
    GradeStudent.create(h.merge(student_id: current_user.id))
    send_request_grades(h.values.join(',')) #, h.head_teacher
  end

  def new
    @grades_course = GradesCourse.new
  end

  def update
    @grades_course.grade_id = get_grade.id
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
    @grades_course.grade_id = get_grade.id
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
