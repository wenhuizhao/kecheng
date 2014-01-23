# -*- encoding : utf-8 -*-
class MessagesController < ApplicationController

  before_filter :get_message, except: [:index, :create, :new, :broadcast]
  before_filter :authenticate_user!
  
  def index
    @all_messages = Message.all_for(current_user)[0, 50]
    @messages = current_user.unread_messages
    @messages.each(&:set_show!)
  end

  def broadcast
    return if request.get?
    return render_alert '请选择至少一个学校' if params[:school_ids].nil?
    return render_alert '请选择至少一个角色' if params[:roles].nil?
    roles = {'teacher' => 3, 'student' => 2}
    if current_user.is_admin_jyj?
      School.find(params[:school_ids]).each do |s|
        s.users.where("role_id in (#{params[:roles].map {|r| roles[r]}.join(',')})").each do |u|
          Message.transaction do
            Message.create(desc: params[:desc], sender_id: current_user.id, receiver_id: u.id)
          end
        end
      end
    elsif current_user.is_admin_xld?

    end
    flash[:notice] = '发送成功！'
    redirect_to messages_path
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
    desc_tail = (@message.desc =~ /主持/ ? "#{@message.desc.match(/老师(.*?)[\,，]+/).to_a[1]}" : @message.desc).to_s + '的请求' 
    if params[:status]
      @message.sync_role(:refused)
      Message.create(base_p.merge(desc: '管理员拒绝了您' + desc_tail))
      redirect_with_message '已经拒绝', action: :index
    else
      @message.sync_role(:approved)
      Message.create(base_p.merge(desc: '管理员通过了您' + desc_tail))
      redirect_with_message '已经批准', action: :index
    end
  end

  private

  def get_message
    @message = Message.find(params[:id])
  end
end
