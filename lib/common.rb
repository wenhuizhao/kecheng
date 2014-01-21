module Common
  def current_period
    @period ||= Period.current_period
  end

  def substr(s, len = 15)
    s.size > len ? s[0,len] + '...' : s
  end
  
  def blanks_arr(content, qtype_id = 1)
    return content.split("#00#") if content =~ /#00#/
    case qtype_id
    when 1
      content.split(/(&nbsp;)+/).join.split(/&nbsp;/)
    when 3
      content.split(/[&nbsp;]{12,}/).join('@@@').split("<span>@@@</span>")
    end
  end
end
