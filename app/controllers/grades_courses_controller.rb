# -*- encoding : utf-8 -*-
class GradesCoursesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :requested_grade, only: [:select_grades, :create, :update]
  before_filter :get_grades_course, except: [:index, :create, :new, :select, :select_grades]
  before_filter :require_teacher, except: [:select, :select_grades, :show]

  def index
    @all_courses = GradesCourse.all_courses_of(current_user)
  end

  def show
  end

  def edit
  end
  
  def select
    return redirect_to select_grades_path unless current_user.grade_accept?
    if request.post?
      params[:student][:course_ids].each do |gcid|
        StudentCourse.where(grades_course_id: gcid.to_i, student_id: current_user.id).first_or_create
      end rescue nil # current_user.clear_selected_courses
      flash[:notice] = '保存成功'
    end
    @all_courses = GradesCourse.for_select(current_user.grade) 
  end

  def select_grades
    return unless request.post?
    return if params[:grade_num].empty?
    GradeStudent.where(student_id: current_user.id, grade_id: @grade.id, is_accept: nil).first_or_create
    send_apply_request('apply_grades', grade_id: @grade.id)
  end

  def new
    @grades_course = GradesCourse.new
  end

  def update
    @grades_course.grade_id = @grade.id
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
    @grades_course.grade_id = @grade.id
    if @grades_course.save
      do_lessons
      send_apply_request('apply_courses', grade_id: @grade.id, course_id: @grades_course.course_id)
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

  def requested_grade
    get_grade
  end
  
  def do_lessons
    1.upto(@grades_course.lesson_num.to_i).each do |i|
      Lesson.where(grades_course_id: @grades_course.id, num: i).first_or_create
    end
  end
  
  def get_grades_course
    @grades_course = GradesCourse.find(params[:id])
  end
end
