module Common
  def current_period
    @period ||= Period.current_period
  end

  def substr(s, len = 15)
    s.size > len ? s[0,len] + '...' : s
  end
  
  def blanks_arr(content, qtype_id = 1)
    return content.split("#00#") if content =~ /#00#/
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
end
