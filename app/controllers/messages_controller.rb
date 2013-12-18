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
  
  def dialog
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(params[:message])
    @message.sender_id = current_user.id
    @message.school_id = current_user.school_id
    @message.grade_id = current_user.grade.try :id
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
    if params[:status]
      @message.sync_role(:refused)
      redirect_with_message '已经拒绝', action: :index
    else
      @message.sync_role(:approved)
      redirect_with_message '已经同意', action: :index
    end
  end

  private

  def get_message
    @message = Message.find(params[:id])
  end
end
