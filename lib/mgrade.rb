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
      return render_alert '请选择班级' if !grade_num.present? || !class_num.present?
      @grade ||= Grade.where(grade_num: grade_num.to_i, 
                             class_num: class_num.to_i, 
                             school_id: current_user.school_id,
                             period_id: Period.current_period.id
                             ).first_or_create
      ac_name = current_user.is_teacher? ? "new" : "select"
      # return render_alert '无此班级' if @grade.nil?
    end

    def send_apply_request(*args)
      type, opts = args[0], args.extract_options! #, opts
      grade_id, course_id = opts.values 
      desc = '申请加入' + Grade.find(grade_id).full_name if type == 'apply_grades'
      if type == 'apply_courses'
        if GradesCourse.has_teacher_for?(grade_id, course_id)
          teacher = GradesCourse.teacher_for(grade_id, course_id).last.teacher
          desc = "#{current_user.real_name}老师申请开通三年级1班的英语课程，该课程目前由#{teacher.real_name}老师主持！"
        else
          desc = '申请' + Grade.find(grade_id).full_name + Course.find(course_id).name + '课'
        end
      end 
      # desc = '申请选课: ' + Grade.find(grade_id).full_name + Course.find(course_id).name if type == 'apply_select_courses'
      Message.where(sender_id: current_user.id, 
                     type_name: type,
                     grade_id: grade_id,
                     course_id: course_id,
                     school_id: current_user.school_id,
                     is_accept: nil,
                     desc: desc).first_or_create
    end
  end

  module Homeworks
    def homeworks_of(month, year = Time.now.year)
      sdate = Time.parse "#{year}-#{month}-01 00:00:00"
      edate = Time.parse "#{year}-#{month}-31 23:59:59"
      homework_rang(sdate, edate)
    end
    
    def homework_rang(sdate, edate)
      homeworks.where("homeworks.created_at < '#{edate}' and homeworks.created_at > '#{sdate}'")
    end
  end
end
