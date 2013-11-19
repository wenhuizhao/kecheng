class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def get_left_courses
    if current_user.is_student?
      @courses ||= current_user.selected_courses
    elsif current_user.is_teacher?
      @courses ||= current_user.opened_courses
    end
  end
  
  def require_admin
    return render text: '您无此权限' unless current_user.is_admin?
  end
end
