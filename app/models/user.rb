#encoding: utf-8
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
  
  def opened_courses
    Course.all
  end

  def selected_courses
    Course.all
  end

  def self.teachers
    select{|u| u.role_name == '教师'}
  end
end
