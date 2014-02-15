class Jyj < ActiveRecord::Base
  attr_accessible :address, :name, :post_code
  validates :name, presence: true 
  has_many :schools
  has_many :users, through: :schools
  has_many :grades, through: :schools
  
  def teachers
    schools.map{|s| s.teachers}.flatten
  end
end
