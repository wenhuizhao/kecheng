# -*- encoding : utf-8 -*-
class Message < ActiveRecord::Base
  attr_accessible :grade_id, :category_id, :desc, :receiver_id, :sender_id, :is_open, :type_name, :parent_id, :is_accept, :course_id, :school_id
  include Mgrade 
  include Grade::Name
  belongs_to :grade
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_and_belongs_to_many :users, join_table: 'users_messages'
  belongs_to :parent, class_name: "Message", foreign_key: "parent_id"
  
  validates :desc, :type_name, :sender_id, presence: true

  scope :system_msgs, -> { where(type_name: 'system') }
  # scope :system_msgs, -> (user) { where(type_name: 'system', school_id: user.school_id) }
  scope :apply_grades_msgs, -> { where(type_name: 'apply_grades') }
  scope :apply_courses_msgs, -> { where(type_name: 'apply_courses') }
  scope :messages_of, -> (user) { where(receiver_id: user.id) }
  
  def content
    # return '申请加入' + grades if is_apply_grades?
    desc
  end

  def is_apply_grades?
    self.type_name == 'apply_grades'
  end

  def is_apply_course?
    self.type_name == 'apply_courses'
  end

  def is_apply?
    is_apply_grades? || is_apply_course? 
  end

  def applied_student
    GradeStudent.where(grade_id: grade_id, student_id: sender_id, is_accept: nil).last
  end
  
  def applied_teacher
    GradesCourse.where(grade_id: self.grade_id, course_id: self.course_id, is_accept: nil).last
  end

  def sync_role(meth)
    send meth
    applied_student.try meth if is_apply_grades? 
    applied_teacher.try meth if is_apply_course?
  end

  def children
    Message.where(parent_id: self.id)
  end

  class << self
    def all_for(user)
      msgs = messages_of(user) + system_msgs
      msgs += apply_grades_msgs.select{|m| user.tgrades.include?(m.grade)} if user.is_teacher?
      msgs += apply_courses_msgs if user.is_admin_xld?
      # msgs.sort_by(&:created_at).reverse
      msgs.sort_by(&:created_at).reverse.reject{|m| !m.parent_id.nil?}
    end
  end
end
