class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def get_left_courses
    if current_user.is_student?
      @courses ||= current_user.selected_courses
    elsif current_user.is_teacher?
      @courses ||= current_user.opened_courses
    end
  end
end
