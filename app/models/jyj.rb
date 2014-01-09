class Jyj < ActiveRecord::Base
  attr_accessible :address, :name, :post_code
  validates :name, presence: true 
  has_many :schools
  
  def teachers
    schools.map{|s| s.teachers}.flatten
  end
end
