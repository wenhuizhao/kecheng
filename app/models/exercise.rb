# -*- encoding : utf-8 -*-
#encoding: utf-8
class Exercise < ActiveRecord::Base
  attr_accessible :answer, :note, :title, :photo, :book_id, :category_id, :qtype_id, :exercise_text_id,
                  :options_attributes, :section_id, :answerphoto
  has_attached_file :photo, :styles => {:thumb => "50x50>"}
  has_attached_file :answerphoto, :styles => {:thumb => "50x50>"}
  belongs_to :book
  belongs_to :category
  has_and_belongs_to_many :homeworks
  has_many :options, :class_name => "ExerciseOption", :foreign_key => "exercise_id"
  accepts_nested_attributes_for :options, :allow_destroy => true, :reject_if =>  :all_blank
  belongs_to :qtype
  belongs_to :exercise_text
  belongs_to :section
  has_many :upload_files
  before_save :clean_content

  def is_fill_blank?
    qtype and qtype.name == "填空题"
  end

  def is_multi_choice?
    qtype and qtype.name == "选择题"
  end
  
  def is_q_and_a?
    qtype and qtype.name == "问答题"
  end


  def clean_content
    transformer = lambda do |env|
      node = env[:node]
      node_name = env[:node_name]
      return if %w[o:p font pre style script meta].include? node_name

      return if (node_name == "p" || node_name == "span" ) and node.content.empty? && node.children.empty?

      style = node.attribute("style")
      if !style.nil?
        styles = style.value.split(";")
        styles.reject! do |s|
          name,value = s.split(":")
          !%w[color background font-style font-weight text-decoration text-align].include?(name)
        end
        style.value=styles.join(";")
        node.remove_attribute(style.name)
      end

      {:node_whitelist => [node]}
    end

    self.title = Sanitize.clean(self.title, :remove_contents => true, :transformers => transformer)
    self.answer = Sanitize.clean(self.answer, :remove_contents => true, :transformers => transformer)

  end
end
