# -*- encoding : utf-8 -*-
class Role < ActiveRecord::Base
  attr_accessible :name, :en_name
  scope :for_user, -> (user) { user.is_admin? ? all : where(['id < ?', user.role_id]) }

  class << self
    def student
      find_by_en_name('student')  
    end
  end
end
