# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :lastname, :firstname, :login, :gender, :auth_code, :school_id, :role_id
  # attr_accessible :title, :body

  validates_uniqueness_of :email, :case_sensitive => false

  validates :login, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
  
  belongs_to :role
  belongs_to :school
  has_many :student_homeworks, foreign_key: 'student_id'
  has_many :homeworks, through: :student_homeworks

  has_many :student_courses, foreign_key: 'student_id'
  # has_many :selected_courses, through: :student_courses

  Role.all.each {|r| define_method("is_#{r.en_name}?") {role and role.name == r.name}}

  def is_admin?
    role_id.nil?
  end

  def name
    firstname || '沒有' 
  end
  
  def role_name
    role ? role.name : '超级管理员'
  end

  def school_name
    school ? school.name : '暂无学校信息'
  end
  
  #teachers
  def opened_courses
    GradesCourse.where(teacher_id: self.id) 
  end
  
  def self.teachers
    select{|u| u.role_name == '教师'}
  end

  #students
  def selected_courses
    StudentCourse.where(student_id: self.id).inject([]) do |courses, sgc|
      courses << sgc.grades_course
    end
  end

  def courses_of_select
    GradesCourse.where(grade_num: self.grade_num, class_num: self.class_num)
  end
  
  def grades
    GradeStudent.where(student_id: self.id).last
  end

  def grade_num
    grades.try :grade_num
  end

  def class_num
    grades.try :class_num
  end

end
