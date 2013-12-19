# -*- encoding : utf-8 -*-
class School < ActiveRecord::Base
  attr_accessible :name, :post_code, :address, :jyj_id
  has_many :users
  has_many :grades
  validates :name, presence: true
  scope :for_user, -> (user) { user.is_admin? ? all : where(id: user.school_id) }

end
