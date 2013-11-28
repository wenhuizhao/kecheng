module Mgrade
  
  def grade_num
    grade.try :grade_num  
  end

  def class_num
    grade.try :class_num
  end
  
  module CtrlMeths
    def get_grade(grade_num = params[:grade_num], class_num = params[:class_num])
      @grade ||= Grade.where(grade_num: grade_num.to_i, class_num: class_num.to_i).last
    end
  end
end
