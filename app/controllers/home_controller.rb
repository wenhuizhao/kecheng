# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @messages = page_objs current_user.unread_messages
  end

  def settings
  end

  def update_books
  	books = Book.for_course.select{|b| b.name =~ /#{App::ChineseNum[params[:grade_num].to_i]}/ && b.name =~ /#{Course.find(params[:course_id]).name}/}
    render partial: 'shared/update_books', locals: {books: books}
  end
end
