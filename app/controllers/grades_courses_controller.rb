# -*- encoding : utf-8 -*-
class GradesCoursesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :require_grade, only: [:create, :update]
  before_filter :get_grades_course, except: [:index, :create, :new, :select, :select_grades, :wait_to_accept_courses]
  before_filter :require_teacher, except: [:select, :select_grades, :show]

  def index
    # params[:history]
    # @periods = Period.histories
    @all_courses = current_user.history_courses
    @periods = @all_courses.map(&:period).uniq 
  end

  def show
    @pname = params[:pname] || @grades_course.period_name
    @grades_course = @grades_course.pcourse(@pname[0, 1]) if params[:pname]
  end

  def edit
  end
  
  def select
    return redirect_to select_grades_path unless current_user.grade_accept?
    if request.post?
      params[:student][:course_ids].each do |gcid|
        StudentCourse.where(grades_course_id: gcid.to_i, student_id: current_user.id).first_or_create
      end rescue nil # current_user.clear_selected_courses
      # flash[:notice] = '选课申请已发出，请等候老师批准'
      flash[:notice] = '选课成功'
    end
    @all_courses = GradesCourse.for_select(current_user.grade) 
  end

  def select_grades
    return unless request.post?
    return if params[:grade_num].empty?
    get_grade
    return  if @grade.nil?
    gs = GradeStudent.where(student_id: current_user.id, grade_id: @grade.id).first
    if @grade and !gs
      GradeStudent.create(student_id: current_user.id, grade_id: @grade.id)
      send_apply_request('apply_grades', grade_id: @grade.id)
    end
  end

  def wait_to_accept_courses
    @wacs ||= current_user.wait_to_accept_courses
  end

  def new
    wait_to_accept_courses
    @wnotice = "您有#{@wacs.size}门课程有待管理员审批"
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
    # return render action: 'new' if GradesCourse.where(period_id: current_period.id, grade_id: @grade.id, course_id: @grades_course.course_id, is_accept: true).size > 0
    @grades_course.teacher_id = current_user.id
    @grades_course.grade_id = @grade.id
    render_alert '没有可用教材' unless params[:grades_course][:book_id].presence
    if @grades_course.save
      do_lessons
      send_apply_request('apply_courses', grade_id: @grade.id, course_id: @grades_course.course_id)
    else
      render action: 'new'
    end
  end

  def destroy
    @grades_course.destroy
    redirect_to grades_courses_path
  end
  
  def students
  end

  def student
    @student = User.find(params[:student_id])
    @sections = @grades_course.sections
  end

  def delete_student
    GradeStudent.where(grade_id: @grades_course.grade_id, student_id: params[:student_id]).delete_all
    redirect_to students_grades_course_path
  end

  def close
    @grades_course.close!
    redirect_to grades_courses_path(history: true)
  end
  
  private

  def require_grade
    get_grade
  end
  
  def do_lessons
    # 1.upto(@grades_course.lesson_num.to_i).each do |i|
    #   Lesson.where(grades_course_id: @grades_course.id, num: i).first_or_create
    # end
  end
  
  def get_grades_course
    @grades_course = GradesCourse.find(params[:id])
    return render_alert '无权限' if current_user.is_teacher? && @grades_course.teacher_id != current_user.id
  end
end
