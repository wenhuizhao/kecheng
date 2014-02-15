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
  # validates :phone, uniqueness: true
  validates :real_name, presence: true
  
  belongs_to :role
  belongs_to :school
  has_many :student_homeworks, foreign_key: 'student_id'
  
  has_and_belongs_to_many :grades, foreign_key: :student_id, join_table: 'grade_students'
  has_and_belongs_to_many :messages, join_table: 'users_messages'
  has_many :student_courses, foreign_key: 'student_id'
  has_many :grade_students, foreign_key: 'student_id'
  has_many :grades_courses, foreign_key: 'teacher_id'
  
  scope :teachers, -> {where(role_id: 3)}
  scope :teachers_of, -> (school) {teachers.where(school_id: school.id)}
  
  def homeworks
    if is_student?
      Homework.joins(:student_homeworks).where("student_homeworks.student_id = #{self.id}")
    else
      Homework.joins(grades_course: :grade).where("grades_courses.teacher_id = #{self.id}")
    end 
  end 

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
  
  # def self.teachers
  #   select{|u| u.role_name == '教师'}
  # end

  def email_required?
    false
  end

  def unread_messages
    # messages
    Message.all_for(self).select{|m| m.is_open == false}
  end
  
  def gender_name
    gender == '男' ? 'male' : 'female'
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
    if is_student?
      courses = selected_courses.inject([]) {|hs, c| hs << c.homeworks - homeworks.joins(:student_homeworks);hs}.flatten
    else
      courses = accepted_courses.inject([]) {|hs, pgc| hs << pgc.homeworks}.flatten.select{|h| h.status.nil?}
    end
    courses.sort_by{|h| h.end_time}
  end

  include Student
  include Teacher
  
  def diff_courses
    return accepted_courses.where('book_id is not null').group('grade_id, course_id') if is_teacher?
    courses.group('course_id') rescue []
  end

end
