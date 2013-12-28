class Jyj < ActiveRecord::Base
  attr_accessible :address, :name, :post_code
  validates :name, presence: true 
  has_many :schools
end
