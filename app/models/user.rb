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
    login
  end
end
