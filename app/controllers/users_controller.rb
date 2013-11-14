class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_user, except: [:index, :create, :new]
  
  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def new
  end

  def update
  end

  def create
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