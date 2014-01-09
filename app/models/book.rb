# -*- encoding : utf-8 -*-
class Book < ActiveRecord::Base
  attr_accessible :name, :category_id, :cover
  belongs_to :category, :class_name => "BookCategory", :foreign_key => "category_id"
  has_many :homeworks
  has_many :exercises
  has_many :exercise_texts
  has_many :sections
  has_attached_file :cover, :styles => {:thumb => "167x241>"}


  def self.for_course
    all
    # select{|b| b.name =~ /(\[.*?\])/}
  end
end
