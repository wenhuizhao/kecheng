class Grade < ActiveRecord::Base
  attr_accessible :class_num, :full_name, :grade_num, :period, :school_id

  after_create :set_full_name

  has_many :grades_courses
  has_many :teachers, through: :grades_courses
  validates :grade_num, :class_num,:school_id, presence: true
  belongs_to :school
  # scope :history_of, -> (user) {all}
  
  def uteachers
    teachers.uniq
  end
  
  def set_full_name
    self.full_name = Name.cname(grade_num, class_num)
    self.save
  end
  
  def school_name
    school.try :name
  end
  
  class << self
    def grades_range
      Grade.select('grade_num').collect(&:grade_num).uniq
    end

    def classes_range
      Grade.select('class_num').collect(&:class_num).uniq
    end

    def max_grade_num
      grades_range.max
    end

    def max_class_num
      classes_range.max
    end
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
