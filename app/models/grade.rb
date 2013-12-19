class Grade < ActiveRecord::Base
  attr_accessible :class_num, :full_name, :grade_num, :period

  after_create :set_full_name

  has_many :grades_courses
  has_many :teachers, through: :grades_courses
  validates :grade_num, :class_num, presence: true

  # scope :history_of, -> (user) {all}
  
  def uteachers
    teachers.uniq
  end
  
  def set_full_name
    self.full_name = Name.cname(grade_num, class_num)
    self.save
  end

  module Name
    def self.cname(gn, cn)
      gn.to_cnum + '年级' + cn.to_cnum + "班"
    end

    def grades
      Name.cname(grade_num, class_num)
    end
  end
end
