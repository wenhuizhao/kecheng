# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :require_admin
  before_filter :get_user, except: [:index, :create_user_from_admin, :new]
  
  def index
    if current_user.is_admin? || current_user.is_admin_jyj?
      @users = User.all
    elsif current_user.is_admin_xld?
      @users = current_user.school.users 
    else
      @users = []
    end
  end

  def show
  end

  def edit
  end

  def new
    @user = User.new
  end

  def update
    if @user.update_attributes(params[:user])
      @user.update_attribute(:role_id, nil) if current_user.is_admin? && current_user.id == @user.id
      redirect_to users_path
    else
      render action: 'edit'
    end
  end

  def create_user_from_admin
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path
    else
      render action: 'new'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end
  
  private

  def get_user
    @user = User.find(params[:id])
  end
  
end
