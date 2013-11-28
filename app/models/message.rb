# -*- encoding : utf-8 -*-
class Message < ActiveRecord::Base
  attr_accessible :grade_id, :category_id, :desc, :receiver_id, :sender_id, :is_open, :type_name, :parent_id, :is_accept
  include Mgrade 
  
  belongs_to :grade
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  
  validates :desc, :type_name, :sender_id, presence: true

  scope :global_messages, -> { where(type_name: 'system') }
  scope :messages_of, -> (user) { where(receiver_id: user.id) }

  def self.all_for(user)
    (messages_of(user) + global_messages).sort_by(&:created_at).reverse
  end

  def content
    # return '申请加入' + grades if is_apply_grades?
    desc
  end

  def is_apply_grades?
    self.type_name == 'apply_grades'
  end

  def grades
    App::ChineseNum[grade_num.to_i] + '年级' + App::ChineseNum[class_num.to_i] + "班"
  end

  def applied_student
    GradeStudent.where(grade_id: grade_id, student_id: sender_id).last
  end

  def approved_applied_student
    self.update_attribute :is_accept, true
    applied_student.try :approved
  end
end
