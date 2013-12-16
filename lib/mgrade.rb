module Mgrade
  
  def grade_num
    grade.try :grade_num  
  end

  def class_num
    grade.try :class_num
  end
  
  def approved
    update_attribute :is_accept, true
  end

  def refused
    update_attribute :is_accept, false
  end

  module CtrlMeths
    def get_grade(grade_num = params[:grade_num], class_num = params[:class_num])
      return redirect_with_message '请选择班级', action: :new if grade_num.empty? || class_num.empty?
      @grade ||= Grade.where(grade_num: grade_num.to_i, class_num: class_num.to_i).last
    end

    def send_apply_request(*args)
      type, opts = args[0], args.extract_options! #, opts
      grade_id, course_id = opts.values 
      desc = '申请加入' + Grade.find(grade_id).full_name if type == 'apply_grades'
      desc = '申请' + Grade.find(grade_id).full_name + Course.find(course_id).name + '课' if type == 'apply_courses'
      Message.where(sender_id: current_user.id, 
                     type_name: type,
                     grade_id: grade_id,
                     course_id: course_id,
                     school_id: current_user.school_id,
                     is_accept: nil,
                     desc: desc).first_or_create
    end
  end
end
