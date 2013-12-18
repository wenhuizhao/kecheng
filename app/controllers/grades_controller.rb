# -*- encoding : utf-8 -*-
class GradesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :require_grade
  before_filter :get_grade, except: [:index, :create, :new]
  
  def index
    @grades = params[:history] ? current_user.history_grades : [current_user.grade]
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
    if @grade.grades_grades.empty?
      @grade.destroy
      redirect_to grades_path
    else
      redirect_with_message '不能删除', action: :index
    end
  end
  
  private

  def require_grade
    return redirect_to select_grades_path unless current_user.grade
  end

  def get_grade
    @grade = Grade.find(params[:id])
  end
end
