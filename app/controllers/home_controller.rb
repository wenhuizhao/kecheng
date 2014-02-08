# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @messages = page_objs current_user.unread_messages
  end

  def settings
  end

  def update_books
    books = get_books(params[:grade_num].to_i, Course.find(params[:course_id]))
    render partial: 'shared/update_books', locals: {books: books}
  end

  def set_book
    gce = GradesCourse.find(params[:grades_course_id])
    gce.update_attribute :book_id, params[:book_id]
    redirect_to grades_course_path(gce)
  end
end
