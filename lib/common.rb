module Common
  def current_period
    @period ||= Period.current_period
  end
end