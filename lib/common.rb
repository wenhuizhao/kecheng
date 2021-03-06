# -*- encoding : utf-8 -*-
module Common
  def current_period
    @period ||= Period.current_period
  end

  def substr(s, len = 15)
    s.size > len ? s[0,len] + '...' : s
  end
  
  def blanks_arr(content, qtype_id = 1)
    return content.split("#00#") if content =~ /#00#/
    return content.split(/[_]{4,}/) if content =~ /[_]{4,}/
    cc = content.split(/(&nbsp;)+/).join.split(/&nbsp;/)
    case qtype_id
    when 1
      cc
    when 3
      new_homework_page ? [content] : content.split(/[&nbsp;]{12,}/).join('@@@').split("<span>@@@</span>") 
    else
      [content]
    end
  end

  def new_homework_page
    controller_name == 'homeworks' && action_name == 'new' rescue nil
  end

  def get_books(grade_num, course)
    grade_name = App::ChineseNum[grade_num]
    course_name = course.name
    @gname = "#{grade_name}年级#{course_name}"
    books = Book.for_course.select{|b| b.name =~ /#{grade_name}/ && b.name =~ /#{course_name}/}
  end
end
