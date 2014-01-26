# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @messages = page_objs current_user.unread_messages
  end

  def settings
  end

  def update_books
    grade_name = App::ChineseNum[params[:grade_num].to_i]
    course_name = Course.find(params[:course_id]).name
  	books = Book.for_course.select{|b| b.name =~ /#{grade_name}/ && b.name =~ /#{course_name}/}
    @gname = "#{grade_name}年级#{course_name}"
    render partial: 'shared/update_books', locals: {books: books}
  end
end
