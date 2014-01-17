module Common
  def current_period
    @period ||= Period.current_period
  end

  def substr(s, len = 15)
    s.size > len ? s[0,len] + '...' : s
  end
  
  def blanks_arr(content)
    content.split(/(&nbsp;)+/).join.split(/&nbsp;/) 
  end
end
