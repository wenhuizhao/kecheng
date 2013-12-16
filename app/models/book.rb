# -*- encoding : utf-8 -*-
class Book < ActiveRecord::Base
  attr_accessible :name, :category_id
  belongs_to :category, :class_name => "BookCategory", :foreign_key => "category_id"
  has_many :homeworks
  has_many :exercises
  has_many :exercise_texts
  has_many :sections

  scope :for_course, -> { where('parent_id is not null') }

  def self.for_course
    select{|b| b.category.grade_num.nil?}
  end
end
