class Section < ActiveRecord::Base
  attr_accessible :book_id, :name, :parent_id, :number
  has_many :sections, :class_name => "Section", :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Section", :foreign_key => "parent_id"
  belongs_to :book
  has_many :exercises
  has_many :exercise_texts
  has_many :homeworks

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
  
end
