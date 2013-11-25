# -*- encoding : utf-8 -*-
#encoding: utf-8
class Exercise < ActiveRecord::Base
  attr_accessible :answer, :note, :title, :photo, :book_id, :category_id, :qtype_id, :exercise_text_id, :options_attributes
  has_attached_file :photo
  belongs_to :book
  belongs_to :category
  has_and_belongs_to_many :homeworks
  has_many :options, :class_name => "ExerciseOption", :foreign_key => "exercise_id"
  accepts_nested_attributes_for :options, :allow_destroy => true, :reject_if =>  :all_blank
  belongs_to :qtype
  belongs_to :exercise_text
end
