# -*- encoding : utf-8 -*-
class GradesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :require_grade, except: [:get_classes]
  before_filter :get_grade, except: [:index, :create, :new, :get_classes]
  
  def index
    @grades = if current_user.is_student?
                params[:history] ? current_user.history_grades : [current_user.grade]
              elsif current_user.is_admin_xld?
                Grade.select{|g| g.school_id == current_user.school_id}
              elsif current_user.is_admin? || current_user.is_admin_jyj?
                Grade.all
              end
  end

  def show
  end

  def edit
  end

  def new
    @grade = Grade.new
  end

  def update
    if @grade.update_attributes(params[:grade])
      @grade.set_full_name
      redirect_to grades_path
    else
      render action: 'edit'
    end
  end

  def create
    @grade = Grade.new(params[:grade])
    if @grade.save
      redirect_to grades_path
    else
      render action: 'new'
    end
  end

  def destroy
    redirect_with_message '不能删除', action: :index
  end

  def get_classes
    render partial: "shared/select_classes", locals: { classes: current_user.school.grades.where(grade_num: params[:grade_num]).collect(&:class_num)}
  end
  
  private

  def require_grade
    return true unless current_user.is_student?
    return redirect_to select_grades_path unless current_user.grade
  end

  def get_grade
    @grade = Grade.find(params[:id])
  end
end
