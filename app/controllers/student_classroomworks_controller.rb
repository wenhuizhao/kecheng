# -*- encoding : utf-8 -*-
class StudentClassroomworksController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_student_classroomwork, except: [:index, :create, :new]

  def show
  end

  def edit
  end

  def new
    @student_homework = StudentHomework.new
  end

  def update
    if @student_classroomwork.update_attributes(params[:student_classroomwork])
      update_exercises
      save_canvas
      if current_user.is_teacher?
#        return render_alert "练习评级不能为空！" unless params[:student_classroomwork][:level].presence
#        return render_alert "请确保所有题目均已批阅！" if @student_classroomwork.student_classroomworks_exercises.any? {|e| !e.check_desc.presence}
        @student_classroomwork.set_first_check
        if @student_classroomwork.auto_finish? || @student_classroomwork.times == 1
          @student_classroomwork.complete
        else
          @student_classroomwork.need_modify
        end
      end
      return re_to_check if params[:commit] == '提交&下一份'
      reto_classroomwork_path
    else
      render_alert '保存失败！'
    end
  end

  def create
    @student_classroomwork = StudentClassroomwork.new(params[:student_classroomwork])
    @student_classroomwork.student_id = current_user.id
    @student_classroomwork
    if @student_classroomwork.save
      update_exercises
      save_canvas
      return re_to_check if params[:commit] == '提交&下一份'
      reto_classroomwork_path
    else
      render action: 'new'
    end
  end

  def check_exercise
    desc = params[:check_desc]
    return render text: desc if !Exercise.checked_icons.include?(desc)
    she = find_she(params[:exercise_id])
    check_desc = desc == 'niubi' ? "#{she.try(:check_desc)},#{desc}" : desc
    she.update_attributes(check_desc: check_desc, teacher_id: current_user.id)
    render text: "批阅成功"
  end

  def save_canvas
    return unless params[:canvass]
    @student_classroomwork.canvas_exercises.each_with_index do |e, i|
      she = find_she(e.id)
      css = JSON.parse(params[:canvass])
      she.update_attribute :canvas, css[i].to_json
    end
    # render text: ''
  end

  def destroy
  end

  private

  def update_exercises
    classroomwork = @student_classroomwork.classroomwork
    classroomwork.exercises.each_with_index do |e, i|
      she = find_she(e.id)
      if current_user.is_student?
        ans = 1.upto(e.blank_size).inject([]) {|s, i| s << params["#{e.id}_#{i}_in"]}.join("@@@ ")
        she.update_attribute :answer, ans
        she.update_attribute :answer, params["#{e.id}option"] if params["#{e.id}option"]
        if e.is_multi_choice? && params["#{e.id}option"].chomp.downcase == e.answer.chomp.downcase
          she.update_attribute :check_desc, 'right'
        else
          she.update_attribute :check_desc, 'wrong'
        end
      elsif current_user.is_teacher?
        she.update_attributes(teacher_id: current_user.id, check_desc: params[:check_desc][i])
      end
      ClassroomworkQuestions.where(user_id: current_user.id, student_classroomworks_exercise_id: she.id).first_or_create.update_attribute(:content, params["question#{she.id}"]) if params["question#{she.id}"].presence
    end
  end

  def find_she(e_id, s_id = @student_classroomwork.id)
    she = StudentClassroomworksExercises.where(student_classroomwork_id: s_id, exercise_id: e_id).first_or_create
  end

  def reto_classroomwork_path
    classroomwork = @student_classroomwork.classroomwork
    grades_course, lesson = classroomwork.grades_course, classroomwork.lesson
    render :create
    # flash[:notice] = current_user.is_student? ? '作业提交成功' : '作业批阅成功'
    # redirect_to section_homework_path(homework.section, homework, grades_course_id: grades_course.id)
  end

  def re_to_check
    redirect_to check_classroomwork_path(@student_classroomwork.classroomwork, status: params[:status])
  end

  def get_student_classroomwork
    @student_classroomwork = StudentClassroomwork.find(params[:id])
  end
end
