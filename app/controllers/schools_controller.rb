# -*- encoding : utf-8 -*-
class SchoolsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_school, except: [:index, :create, :new]
  before_filter :require_admin
  
  def index
    @schools = School.all
  end

  def show
  end

  def edit
  end

  def new
    @school = School.new
  end

  def update
    if @school.update_attributes(params[:school])
      redirect_to schools_path
    else
      render action: 'edit'
    end
  end

  def create
    @school = School.new(params[:school])
    if @school.save
      redirect_to schools_path
    else
      render action: 'new'
    end
  end

  def destroy
    redirect_with_message '不能删除', action: :index
  end
  
  private

  def get_school
    @school = School.find(params[:id])
  end
end
