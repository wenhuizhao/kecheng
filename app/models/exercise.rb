# -*- encoding : utf-8 -*-
require 'sanitize'
class Exercise < ActiveRecord::Base
  attr_accessible :answer, :note, :title, :photo, :book_id, :category_id, :qtype_id, :exercise_text_id,
                  :options_attributes, :section_id, :answerphoto, :lesson_num
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
  has_and_belongs_to_many :student_homeworks , join_table: 'student_homeworks_exercises'
  
  delegate :content, to: :exercise_text

  def is_fill_blank?
    qtype_name == "填空题"
  end

  def is_multi_choice?
    qtype_name == "选择题"
  end
  
  def is_q_and_a?
    qtype_name == "问答题"
  end

  def is_lianxian?
    qtype_name == '连线题'
  end

  def is_need_canvas?
    is_lianxian? || is_math_qa?
  end

  def is_math_qa?
    is_q_and_a? && book.try(:is_math?)
  end

  def qtype_name
    qtype.try(:name)
  end

  def is_need_area?
    # is_q_and_a?
  end

  def answer_sta_of(homework)
    return '该作业下没有此练习题' if !homework.exercises.include?(self)
    total = homework.student_homeworks.where("first_update is not null")
    rnum, wnum = 0, 0
    total.each do |sh| 
      she = StudentHomeworksExercises.where(student_homework_id: sh.id, exercise_id: self.id).last 
      next if she.nil?
      rnum += 1 if she.right 
      wnum += 1 if she.wrong 
    end
    "做对#{rnum}人，做错#{wnum}人，共#{total.count}人"
  end

  def clean_content
    transformer = lambda do |env|
      node = env[:node]
      node_name = env[:node_name]
      return if %w[o:p font pre style script meta].include? node_name

#      return if (node_name == "p" || node_name == "span" ) and node.content.empty? && node.children.empty?

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

#    self.title = Sanitize.clean(self.title, :remove_contents => true, :transformers => transformer)
#    self.answer = Sanitize.clean(self.answer, :remove_contents => true, :transformers => transformer)

  end

  def save_png(data)
    png = Base64.decode64(data)
    save_to_file(png)
  end

  def save_to_file(data, path = "#{Rails.root}/public/canvas")
    Dir.mkdir(path, 0777) unless Dir.exist?(path)
    File.open(path + "/#{id}.png", 'wb+'){ |f| f.write(data) }
  end
 
  include Common
 
  def blank_size
    blanks_arr(title, qtype_id).size
  end

  def input_type
    is_fill_blank? ? 'input' : "textarea"
  end

  def short_answer
    Sanitize.clean(answer).try(:truncate, 10)
  end
  
  class << self  
    def check_icons
      # %w(right wrong edit message niubi)
      %w(right wrong message niubi)
    end

    def checked_icons
      %w(right wrong niubi)
    end
  end
end
