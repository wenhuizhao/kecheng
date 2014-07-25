# -*- encoding : utf-8 -*-
class Section < ActiveRecord::Base
  attr_accessible :book_id, :name, :parent_id, :number, :num_lessons
  has_many :sections, :class_name => "Section", :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Section", :foreign_key => "parent_id"
  belongs_to :book
  has_many :exercises
  has_many :exercise_texts
  has_many :homeworks
  has_many :classroomworks

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

  def course_classroomworks(course)
    classroomworks.where(grades_course_id: course.id)
  end

  def finished_classroomworks(course)
    course_classroomworks(course).where(status: '1')
  end

  def unfinished_classroomworks(course)
    course_classroomworks(course).where(status: nil)
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

  def lesson_categories lesson
    SectionLessonCategory.where(section_id: self.id, lesson: lesson).map(&:category)
  end

  def lesson_exercises lesson
    self.exercises.where(:lesson_num=>lesson)
  end
end
