# -*- encoding : utf-8 -*-
class MessagesController < ApplicationController

  before_filter :get_message, except: [:index, :create, :new]
  before_filter :authenticate_user!
  
  def index
    @all_messages = Message.all_for(current_user)[0, 50]
    @messages = current_user.unread_messages
    @messages.each(&:set_show!)
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
    ok = if params[:grade_id].presence
           Grade.find(params[:grade_id]).build_messages(sender_id: current_user.id, desc: params[:message][:desc])
         else
           @message = Message.new(params[:message])
           @message.receiver_id = params[:receiver_id].presence
           @message.sender_id = current_user.id
           @message.school_id = current_user.school_id
           @message.save
         end
    return redirect_to root_path if ok
    render action: 'new'
  end

  def destroy
    @message.destroy
    redirect_to messages_path
  end
  
  def accept_select_grades
    base_p = {sender_id: current_user.id, receiver_id: @message.sender_id, school_id: current_user.school_id}
    if params[:status]
      @message.sync_role(:refused)
      Message.create(base_p.merge(desc: '管理员拒绝了您' + @message.desc + '的请求'))
      redirect_with_message '已经拒绝', action: :index
    else
      @message.sync_role(:approved)
      Message.create(base_p.merge(desc: '管理员通过了您' + @message.desc + '的请求'))
      redirect_with_message '已经批准', action: :index
    end
  end

  private

  def get_message
    @message = Message.find(params[:id])
  end
end
