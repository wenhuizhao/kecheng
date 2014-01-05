class Period < ActiveRecord::Base
  attr_accessible :desc, :end_year, :full_name, :is_current, :start_year
  after_create :set_full_name

  def set_full_name
    self.full_name = "#{start_year}-#{end_year}学年#{desc}学期"
    self.save
  end

  def current?
    self == Period.current_period
  end

  def months
    desc == "上" ? (8..12).to_a << 1 : (2..7).to_a
  end

  class << self
    def current_period
      desc = (2..7).to_a.include?(Time.now.month) ? "下" : "上"
      year = Time.now.month == 1 ? Time.now.year - 1 : Time.now
      cp = where(start_year: year, is_current: true, desc: desc).last
      return cp if cp
      cp = create(start_year: year, end_year: year + 1, desc: desc, is_current: true)
    end
  end
end
