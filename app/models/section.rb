# -*- encoding : utf-8 -*-
class Section < ActiveRecord::Base
  attr_accessible :book_id, :name, :parent_id, :number
  has_many :sections, :class_name => "Section", :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Section", :foreign_key => "parent_id"
  belongs_to :book
  has_many :exercises
  has_many :exercise_texts
  has_many :homeworks

  after_create :set_num

  def set_num
    self.num = Book.find(self.book_id).sections.size
    self.save
  end

  def course_homeworks(course)
    homeworks.where(grades_course_id: course.id)
  end
  
  def finished_homeworks(course)
    course_homeworks(course).where(status: '1')
  end

  def unfinished_homeworks(course)
    course_homeworks(course).where(status: nil)
  end

  def num_name
    "#{number} #{name}"
  end

  def line_num
    # name.split(/([\d\.]{3,})/)[1] || number.match(/[\d\.]+/) 
    name.split(/([\d\.]{3,})/)[1] || name 
  end

  def line_name
    name.split(/([\d\.]{3,})/)[2]
  end

end
