# -*- encoding : utf-8 -*-
class JyjsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_jyj, except: [:index, :create, :new]
  before_filter :require_admin
  
  def index
    @jyjs = Jyj.all
  end

  def show
  end

  def edit
  end

  def new
    @jyj = Jyj.new
  end

  def update
    if @jyj.update_attributes(params[:jyj])
      redirect_to jyjs_path
    else
      render action: 'edit'
    end
  end

  def create
    @jyj = Jyj.new(params[:jyj])
    if @jyj.save
      redirect_to jyjs_path
    else
      render action: 'new'
    end
  end

  def destroy
    @jyj.destroy
    redirect_with_message '不能删除', action: :index
  end
  
  private

  def get_jyj
    @jyj = Jyj.find(params[:id])
  end
end
