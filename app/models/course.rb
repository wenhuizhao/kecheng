# -*- encoding : utf-8 -*-
class Course < ActiveRecord::Base
  attr_accessible :desc, :name

  validates :name, presence: true
  has_many :grades_courses
    
end
