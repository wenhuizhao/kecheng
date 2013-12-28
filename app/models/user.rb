# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :lastname, :firstname, :login, :gender, :auth_code, :school_id, :role_id, :real_name, :phone

  # validates_uniqueness_of :email, :case_sensitive => false

  validates :login, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
  # validates :phone, presence: true, uniqueness: true, length: { minimum: 11, maximum: 13 }
  validates :real_name, presence: true
  
  belongs_to :role
  belongs_to :school
  has_many :student_homeworks, foreign_key: 'student_id'
  has_many :homeworks, through: :student_homeworks
  
  has_and_belongs_to_many :grades, foreign_key: :student_id, join_table: 'grade_students'
  has_and_belongs_to_many :messages, join_table: 'users_messages'
  has_many :student_courses, foreign_key: 'student_id'
  has_many :grade_students, foreign_key: 'student_id'

  Role.all.each {|r| define_method("is_#{r.en_name}?") {role and role.name == r.name}}

  # ACCESSABLE_ATTRS = [:name, :password, :password_confirmation]
  
  def is_admin?
    role_id.nil?
  end

  def admins?
    role_name.include?("管理员")
  end

  def name
    real_name || '沒有' 
  end
  
  def role_name
    role.try(:name) || '超级管理员'
  end

  def school_name
    school.try(:name) || '暂无学校信息'
  end
  
  def self.teachers
    select{|u| u.role_name == '教师'}
  end

  def email_required?
    false
  end

  def unread_messages
    # messages
    Message.all_for(self).select{|m| m.is_open == false}
  end

  def jyj
    Jyj.first
  end

  def set_bg_num
    if self.bg_num.to_i < 2
      self.bg_num = self.bg_num.to_i + 1
    else
      self.bg_num = '0'
    end
    self.save
  end

  def undo_homeworks
    return selected_courses.inject([]) {|hs, c| hs << c.homeworks - homeworks;hs}.flatten if self.is_student?
    accepted_courses.inject([]){|hs, pgc| hs << pgc.homeworks}.flatten.select{|h| h.status.nil?}
  end

  include Student
  include Teacher
end
