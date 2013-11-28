# -*- encoding : utf-8 -*-
class MessagesController < ApplicationController

  before_filter :get_message, except: [:index, :create, :new]
  before_filter :authenticate_user!
  
  def index
  	@messages = Message.all_for(current_user)
  end
  
  def show
  end

  def edit
  end

  def new
    @message = Message.new
  end

  def update
    if @message.update_attributes(params[:message])
      redirect_to messages_path
    else
      render action: 'edit'
    end
  end

  def create
    @message = Message.new(params[:message])
    @message.sender_id = current_user.id
    if @message.save
      redirect_to messages_path
    else
      render action: 'new'
    end
  end

  def destroy
    @message.destroy
    redirect_to messages_path
  end
  
  def accept_select_grades
    @message.approved_applied_student
    flash[:notice] = '已经同意'
    redirect_to messages_path
  end

  private

  def get_message
    @message = Message.find(params[:id])
  end
end
