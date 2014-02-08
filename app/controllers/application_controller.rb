# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :get_common_courses, :get_back
  include Exts, Tool, CtrlMeths, Common
  include Mgrade::CtrlMeths

  private
    def get_back
      session[:back] = @url = request.url
    end

    def get_common_courses
      return nil unless current_user
      if current_user.is_student?
        @courses ||= current_user.selected_courses
      elsif current_user.is_teacher?
        # @courses ||= current_user.accepted_courses
        @courses ||= current_user.accepted_courses
      else
        @courses ||= User.find(params[:teacher_id]).accepted_courses if params[:teacher_id]
      end
    end
    
    def require_teacher
      return render_alert '您无此权限' if current_user.is_student?
    end
    
    def require_admin
      return render_alert '您无此权限' if current_user.is_student? || current_user.is_teacher?
    end

    def redirect_with_message(*args)
      msg, opts = args[0], args.extract_options!
      raise '必须指定一个action' unless opts.has_key?(:action)
      @notice = flash[opts[:msg_type] || :notice] = msg if msg.is_a?String
      redirect_to opts
    end
end
