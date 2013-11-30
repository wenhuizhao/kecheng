# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :get_left_courses
  include Exts
  include Tool
  include Mgrade::CtrlMeths

  private
    def get_left_courses
      return nil unless current_user
      if current_user.is_student?
        @courses ||= current_user.selected_courses
      elsif current_user.is_teacher?
        @courses ||= current_user.accepted_courses
      else
        @courses ||= User.find(params[:teacher_id]).opened_courses if params[:teacher_id]
      end
    end
    
    def require_teacher
      return render text: '您无此权限' if current_user.is_student?
    end
    
    def require_admin
      return render text: '您无此权限' unless current_user.is_admin?
    end

    def redirect_with_message(*args)
      msg, opts = args[0], args.extract_options!
      raise '必须指定一个action' unless opts.has_key?(:action)
      flash[opts[:msg_type] || :notice] = msg if msg.is_a?String
      redirect_to opts
    end
end
