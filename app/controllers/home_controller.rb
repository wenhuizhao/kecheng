# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  before_filter :authenticate_user!, except: [:check_user]
  
  def index
    @messages = page_objs current_user.unread_messages
  end

  def settings
  end

  def update_books
    return unless params[:course_id]
    books = get_books(params[:grade_num].to_i, Course.find(params[:course_id]))
    render partial: 'shared/update_books', locals: {books: books}
  end

  def set_book
    gce = GradesCourse.find(params[:grades_course_id])
    gce.update_attribute :book_id, params[:book_id]
    gce.pcourse.close! if params[:book_id].presence
    redirect_to grades_course_path(gce)
  end

  def check_user
    col = params[:hid].gsub("user_","")
    val = params[:val]
    err = true if val.size < (col == 'real_name' ? 2 : 3)
    unless err
      case col
      when 'login'
        err = User.where(login: val).count > 0
      when 'password'
        err = val.size < 6
        session[:rpass] = val
      when 'password_confirmation'
        err = session[:rpass] != val
      when 'phone'
        err = !(val =~ /1[358]+\d[\d]{8}/)
      end
    end
    render text: (err ? 'error' : 'succ')
  end
end
