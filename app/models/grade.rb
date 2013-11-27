class Grade < ActiveRecord::Base
  attr_accessible :class_num, :full_name, :grade_num, :period

  after_create :set_full_name
  
  def set_full_name
    self.full_name = App::ChineseNum[self.grade_num] + '年级' + App::ChineseNum[self.class_num] + "班"
    self.save
  end
end
